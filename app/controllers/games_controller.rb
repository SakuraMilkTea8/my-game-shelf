class GamesController < ApplicationController
  # helper_method :find_videos
  skip_before_action :authenticate_user!, only: [:index, :show]
  # require 'google/apis/youtube_v3'
  # require 'active_support/all'
  # GOOGLE_API_KEY="AIzaSyAGH5jocDGqi74r4gisEbvXkWxuxCr-1SM"

  def index
    # creates the link path to get the users show page
    @user = current_user
    # for the search bar
    if params[:query].present?
      @games = policy_scope(Game).search_by_title_and_genre(params[:query])
    else
      @games = Game.all
      @games = policy_scope(Game).order(created_at: :desc)
    end
  end

  def show
    # creates the link path to get the users show page
    @user = current_user
    @games = Game.all
    @game = Game.find(params[:id])
    authorize @game
    @streams = get_twitch_streams(@game.title)
    raise
    # if the user is not signed in they cannot add a game to a list
    if user_signed_in?
      # list_game is either present with an id or not yet made
      @shelf_game = current_user.shelf_games.find_by(game: @game) || ShelfGame.new
      # You need this to make a new review in the show page
    end
    @review = Review.new
    ratings = []
    @rating = 0
    @game.reviews.each do |review|
      ratings << review.rating
    end
    @rating = ratings.sum / ratings.length unless ratings.empty?
    # still not perfect but much better than before
    recommended_games = recommended(@game)
    @three_games = recommended_games.keys.first(3)
    @videos
  end


  private

  def find_videos(keyword, after: 80.months.ago, before: Time.now)
    service = Google::Apis::YoutubeV3::YouTubeService.new
    service.key = GOOGLE_API_KEY
    next_page_token = nil
    opt = {
      q: keyword,
      type: 'video',
      max_results: 1,
      order: :date,
      page_token: next_page_token,
      published_after: after.iso8601,
      published_before: before.iso8601
    }
    results = service.list_searches(:snippet, q: keyword)
      results.items.each do |item|
      id = item.id
      snippet = item.snippet
      puts "\"#{snippet.title}\" by #{snippet.channel_title} (id: #{id.video_id}) (#{snippet.published_at})"
    end
  end

  def get_tags(game)
    game_tags = []
    game.genre.split(",").each do |genre|
      game_tags << genre
    end
    # comment out to test off heroku from here -->
    game.developer.split(",").each do |dev|
      game_tags << dev
    end
    # <-- to here
    return game_tags
  end

  def tally_recommendations(games_array)
    # tallies the games into a hash and organizes it by highest tally first
    return games_array.tally.sort_by { |_key, value| -value }.to_h
  end

  def recommended(game)
    all_games = Game.all
    game_tags = get_tags(game)
    recommended_games = []
    # check for each tag in each other game
    game_tags.each do |tag|
      all_games.each do |current_game|
        tags = get_tags(current_game)
        recommended_games << current_game if tags.include?(tag) && current_game.title != game.title
      end
    end
    return tally_recommendations(recommended_games)
  end

  require 'json'
  require 'net/http'
  require 'uri'

  def get_twitch_streams(game)
    game_query = game.downcase
    uri = URI.parse("https://api.twitch.tv/helix/games?name=#{game_query}")
    request = Net::HTTP::Get.new(uri)
    request["Client-Id"] = ENV['TWITCH_CLIENT_ID']
    request["Authorization"] = "Bearer #{ENV['TWITCH_TOKEN']}"

    req_options = {
      use_ssl: uri.scheme == "https",
    }

    response = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(request)
    end
    resp = JSON.parse(response.body)["data"]
    game_id = resp.first['id']

    stream_uri = URI.parse("https://api.twitch.tv/helix/streams?game_id=#{game_id}")
    stream_request = Net::HTTP::Get.new(stream_uri)
    stream_request["Client-Id"] = ENV['TWITCH_CLIENT_ID']
    stream_request["Authorization"] = "Bearer #{ENV['TWITCH_TOKEN']}"

    req_options = {
      use_ssl: stream_uri.scheme == "https",
    }

    response = Net::HTTP.start(stream_uri.hostname, stream_uri.port, req_options) do |http|
      http.request(stream_request)
    end
    stream_resp = JSON.parse(response.body)["data"]
    return stream_resp

    # if !resp.empty?
    #   user = resp.select{ |user| user["broadcaster_login"] == "#{query}" }[0]
    #   p user
    #   if user["is_live"] == true
    #     return "El usuario #{query} está transmitiendo en vivo jugando #{user["game_name"]}!!! 🔴\nMíralo en https://www.twitch.tv/#{query}"
    #   else
    #     return "El usuario #{query} no está transmitiendo en este momento, en su última transmición jugó #{user["game_name"]}.\nSíguelo en https://www.twitch.tv/#{query}"
    #   end
    # else
    #   return "#{query}? Quién te conoce papá?."
    # end
  end
end
