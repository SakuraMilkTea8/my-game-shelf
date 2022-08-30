require 'json'
require 'open-uri'

# ShelfGame.destroy_all
User.destroy_all

if ENV['minimal'] == 'yes'
  Game.destroy_all

  description_placeholder = "Tennis for Two (also known as Computer Tennis) is a sports video game that simulates a game of tennis, and was one of the first games developed in the early history of video games. American physicist William Higinbotham designed the game in 1958 for display at the Brookhaven National Laboratory's annual public exhibition after learning that the government research institution's Donner Model 30 analog computer could simulate trajectories with wind resistance. He designed the game within a few hours, after which he and technician Robert V. Dvorak built it over a period of three weeks. The game was displayed on an oscilloscope and played with two custom aluminum controllers. Its visuals show a representation of a tennis court viewed from the side, and players adjust the angle of their shots with a knob on their controller and try to hit the ball over the net by pressing a button."
  url = "https://api.rawg.io/api/games?key=#{ENV['RAWG_API']}"
  doc = URI.parse(url).open.read
  response = JSON.parse(doc)
  games = response['results']
  games.take(20).each do |game|
    genres = []
    game['genres'].each { |hash| genres << hash['name'] }
    platforms = []
    game['platforms'].each { |hash| platforms << hash['platform']['name'] }
    this = Game.new(title: game['name'], genre: genres.join(","), developer: "Hamish Liu", console: platforms.join(","), description: description_placeholder, price: 3.5, release_date: game['released'], image_url: game['background_image'])
    this.save
    p this.title
  end
end

  # the following will do 21 api calls, please don't do until it's on heroku and we're not likely to put any more
if ENV['detailed'] == 'yes'
  Game.destroy_all


  url = "https://api.rawg.io/api/games?key=#{ENV['RAWG_API']}"
  doc = URI.parse(url).open.read
  response = JSON.parse(doc)
  results = response['results']
  results.take(20).each do |result|
    # can get more game info at "https://api.rawg.io/api/games/#{game['id']}?key=#{ENV['RAWG_API']}"
    game_url =  "https://api.rawg.io/api/games/#{result['id']}?key=#{ENV['RAWG_API']}"
    game_doc = URI.parse(game_url).open.read
    game = JSON.parse(game_doc)
    # details has two or more developers usually so loop through (detailed) game['developers'].each |dev| and put the dev['name'] into an array
    developers = []
    game['developers'].each { |dev| developers << dev['name'] }
    # should probably join all of them by comma, no space maybe
    # if using detailed game all keys are the same, 'description' gives a description with p tags and breaks 'description_raw' has breaks but no html
    genres = []
    game['genres'].each { |genre| genres << genre['name'] }
    platforms = []
    game['platforms'].each { |platform| platforms << platform['platform']['name'] }
    # add   description: game['description_raw']    after migrating
    this = Game.new(title: game['name'], description: game['description_raw'], genre: genres.join(","), developer: developers.join(','), console: platforms.join(","), price: 3.5, release_date: game['released'], image_url: game['background_image'])
    this.save
    p this.title
  end
end

if ENV['super'] == 'yes'
  Game.destroy_all

  ids = %w"428839 46508 1358 15272 326248 327236 262382 326243 50734 51610 2551 41494 278 259801 282825 58858 622495 51323 667657 10141 422859 452638 244741 60074 22509 654 9767 9600 287342 10419 58835 44525 369157 492 421698 11839 47326 27977 22511 302974 56092 27023 27057 27015 25924 26824 53205 13554 19299 5562 5563 11859 58175 32 3070 2454 1030 4286 13537 28 802 3439 4062 13536 12020 5679 4291 5286 4200 3328 3498"
  ids.each do |id|
    game_url =  "https://api.rawg.io/api/games/#{id}?key=#{ENV['RAWG_API']}"
    game_doc = URI.parse(game_url).open.read
    game = JSON.parse(game_doc)
    # details has two or more developers usually so loop through (detailed) game['developers'].each |dev| and put the dev['name'] into an array
    developers = []
    game['developers'].each { |dev| developers << dev['name'] }
    # should probably join all of them by comma, no space maybe
    # if using detailed game all keys are the same, 'description' gives a description with p tags and breaks 'description_raw' has breaks but no html
    genres = []
    game['genres'].each { |genre| genres << genre['name'] }
    platforms = []
    game['platforms'].each { |platform| platforms << platform['platform']['name'] }
    # add   description: game['description_raw']    after migrating
    this = Game.new(title: game['name'], description: game['description_raw'], genre: genres.join(","), developer: developers.join(','), console: platforms.join(","), release_date: game['released'], image_url: game['background_image'])
    this.save
    p this.title
  end
end

puts 'adding users'

# users!
seedyboi = User.new(name: 'Seedy Seed Boi', email: 'seedy@seed.com', password: '123456')
seedyboi.save!
mike = User.new(name: 'mikeysnakes', email: 'mike@gmail.com', password: '123456')
mike.save!
marie = User.new(name: 'hayataroMama', email: 'marie@gmail.com', password: '123456')
marie.save!
hamish = User.new(name: 'hamtaro', email: 'hamish@gmail.com', password: '123456')
hamish.save!
ellie = User.new(name: 'poutineLuvr', email: 'ellie@gmail.com', password: '123456')
ellie.save!

p seedyboi.name

p 'Seedyboi is looking for a game to add to their shelf...'

seedy_game = ShelfGame.new(category: 'want to play')
seedy_game.user = seedyboi
seedy_game.game = Game.first
seedy_game.save!

p "#{seedy_game.user.name} added #{seedy_game.game.title} to their shelf under #{seedy_game.category}"

# reviews

content = "wow amazing game, it really changed my life"
all_users = User.all
all_games = Game.all
all_users.each do |user|
  review = Review.new(content: content, rating: rand(4..5), user: user, game: all_games.sample)
  review.save!
end

content = "meeeeeh"
all_users = User.all
all_games = Game.all
all_users.each do |user|
  review = Review.new(content: content, rating: rand(2..3), user: user, game: all_games.sample)
  review.save!
end

content = "I'd rather play Duke Nukem Forever"
all_users = User.all
all_games = Game.all
all_users.each do |user|
  review = Review.new(content: content, rating: 1, user: user, game: all_games.sample)
  review.save!
end

# require 'google/apis/youtube_v3'
# require 'active_support/all'
# GOOGLE_API_KEY=ENV['GOOGLE_API_KEY']

# def find_videos(keyword, after: 1.months.ago, before: Time.now) #検索キーワードと検索範囲を変えれるように引数に値を取っています
#   service = Google::Apis::YoutubeV3::YouTubeService.new
#   service.key = GOOGLE_API_KEY
#   next_page_token = nil
#   opt = {
#     q: keyword,
#     type: 'video',
#     max_results: 1,
#     order: :date,
#     page_token: next_page_token,
#     published_after: after.iso8601,
#     published_before: before.iso8601
#   }
#   results = service.list_searches(:snippet, q: keyword)
#   results.items.each do |item|
#     id = item.id
#     snippet = item.snippet
#     puts "\"#{snippet.title}\" by #{snippet.channel_title} (id: #{id.video_id}) (#{snippet.published_at})"
#   end
# end
# find_videos('team fortress 2 trailer')
