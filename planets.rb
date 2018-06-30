require 'csv'
require 'awesome_print'
require 'catpix'
require 'launchy'


$solar_system_data = CSV.read("Solar System.csv", headers: true, header_converters: :symbol)
ap $solar_system_data.class # CSV::Table < Object
ap "WELCOME TO THE SOLAR SYSTEM!"

def explore_planet()
  ap $solar_system_data.by_col[:name]
  prompt = "Where would you like to start? 0 - #{$solar_system_data.length}"
  ap prompt
  input = gets.chomp
  
  $selected_planet = $solar_system_data[input.to_i]
  until $selected_planet && /\d/.match(input)
    ap prompt
    input = gets.chomp
    $selected_planet = $solar_system_data[input.to_i]
  end

  ap $selected_planet

  prompt = "Do you want to LEARN or SEE?"
  ap prompt

  while input = gets.chomp
    case input.downcase
    when "learn"
      Launchy.open($selected_planet[:uri])
      return
    when "see"
      Catpix::print_image $selected_planet[:image]
      return
    else
      ap prompt
    end
  end
end
explore_planet()

def select_attribute()
  ap "Which attribute do want to see for each planet (ex: number_of_moons)?"
  ap $solar_system_data.headers.to_s
  attribute = gets.chomp

  ap "Here are the #{attribute} findings:"
  $solar_system_data.each do |row|
    ap "#{row[:name]} --> #{attribute}: #{row[attribute.to_sym]}"
  end
end
select_attribute()

prompt = "SELECT another attribute or EXPLORE another planet?"
ap prompt

while input = gets.chomp
  case input.downcase
  when "select"
    select_attribute()
  when "explore"
    explore_planet()
  else
    ap prompt
  end
end

