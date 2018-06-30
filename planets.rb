require 'csv'
require 'awesome_print'
require 'catpix_mini'
require 'launchy'


$solar_system_data = CSV.read("Solar System.csv", headers: true, header_converters: :symbol)
ap $solar_system_data.class # CSV::Table < Object
ap "WELCOME TO THE SOLAR SYSTEM!"

def explore_planet()
  ap $solar_system_data.by_col[:name]
  prompt = "Where would you like to start? 0 - #{$solar_system_data.length}"
  ap prompt
  input = gets.chomp

