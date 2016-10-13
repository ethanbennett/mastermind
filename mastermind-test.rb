require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require './mastermind.rb'
require_relative 'player-input'

class GameTimeTest < Minitest::Test
  def test_the_numbers_shuffled
    a = GameTime.new
    refute @secret_answer.eql? "rgyb"
  end


end
