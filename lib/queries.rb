# Write methods that return SQL queries for each part of the challeng here
require_relative '../config/environment.rb'

def guest_with_most_appearances
  # write your query here!
  """
  SELECT raw_guest_list
  FROM daily_show_guests
  ORDER BY COUNT(raw_guest_list) DESC LIMIT 1
  ;
  """
end

def most_popular_profession_for_each_year
  """
  SELECT googleknowledge_occupation
  FROM daily_show_guests
  """
end

binding.pry
0
