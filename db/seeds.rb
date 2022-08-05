# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'json'
require 'open-uri'

List.destroy_all
User.destroy_all

if ENV['minimal'] == 'yes'
  Game.destroy_all
  List.destroy_all
  User.destroy_all


  url = "https://api.rawg.io/api/games?key=#{ENV['RAWG_API']}"
  doc = URI.parse(url).open.read
  response = JSON.parse(doc)
  games = response['results']
  games.take(20).each do |game|
    genres = []
    game['genres'].each { |hash| genres << hash['name'] }
    platforms = []
    game['platforms'].each { |hash| platforms << hash['platform']['name'] }
    this = Game.new(title: game['name'], genre: genres.join(" "), developer: "Hamish Liu", console: platforms.join(" "), price: 3.5, release_date: game['released'], image_url: game['background_image'])
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
      this = Game.new(title: game['name'], genre: genres.join(","), developer: developers.join(','), console: platforms.join(","), price: 3.5, release_date: game['released'], image_url: game['background_image'])
      this.save
      p this.title
  end
end

puts 'Makin that seedy boi'

seedyboi = User.new(email: 'seedy@seed.com', password: '123456', name: 'Seedy Seed Boi')
seedyboi.save!

p seedyboi.name

List.create(name: 'completed', user_id: seedyboi.id)
List.create(name: 'currently playing', user_id: seedyboi.id)
List.create(name: 'want to play', user_id: seedyboi.id)
