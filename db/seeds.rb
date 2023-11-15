# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Creating list of movies..."
puts "Getting movies from the TMDB API..."

require 'json'
require 'open-uri'
url = "https://tmdb.lewagon.com/movie/top_rated"
response = URI.open(url).read
data = JSON.parse(response)
movies_array = data["results"]
img_url = "https://image.tmdb.org/t/p/w500"

puts "Creating movie objects..."

movies_array.each do |movie|
  new_movie = Movie.new(
    title: movie["title"],
    overview: movie["overview"],
    poster_url: img_url+movie["poster_path"],
    rating: movie["vote_average"]
  )
  new_movie.save!
end

puts "Movies done! Now for the lists..."
puts "Creating three lists..."

List.create!(name: "Hilairous Hijinks")
List.create!(name: "Thrilling Thrillers")
List.create!(name: "Festive Favourites")

puts "All done! Roll camera!"
