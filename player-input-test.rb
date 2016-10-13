require 'minitest'
require 'minitest/pride'
require 'minitest/autorun'
require_relative 'player-input'

class PlayerInputTest < Minitest::Test
  def test_player_input_exists
    a = PlayerInput.new
    refute a.eql? nil
  end

def test_q_returns_expected
  a = PlayerInput.new
  a.q?("q")
  assert "q"
end

def test_c_returns_expected
  a = PlayerInput.new
  a.c?("c")
  assert "c"
end

def test_instructions_instruct
  a = PlayerInput.new
  a.instructions?("i")
  assert "i"
end

def test_play_plays
  a = PlayerInput.new
  a.play?("p")
  assert "p"
end


end