require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require './mastermind.rb'
require_relative 'player-input'

class GameTimeTest < Minitest::Test

# The parts of this code that rely on user
# input were much easier to test in pry, which
# was a critical part of developing the many
# conditional statements here. I tried to walk 
# through it with tests, but I wasn't sure how to
# navigate the conditionals--without running
# normally with user input, all the variables
# evaluate to nil.

end
