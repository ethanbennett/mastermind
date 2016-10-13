require 'pry'
require 'audite'
require_relative 'player-input'

class GameTime < PlayerInput

  attr_reader           :secret_answer
  attr_accessor         :count
                        :timer_start
                        :timer_end
                        :minutes
                        :seconds
                        :second_count
  
  def initialize
    @secret_answer     = ["r", "g", "y", "b"].shuffle.join
    @count             = 0
    @timer_start       = Time.now
    @timer_end         = 0
    @second_count      = 0
    @minutes           = 0
    @seconds           = 0
  end

  def intro
    puts "\nWelcome to MASTERMIND. Would you like to (p)lay, read the (i)nstructions, or (q)uit?\n\n"
    input = gets.chomp.downcase
    start              if play?(input)
    instructing_stuff  if instructions?(input)
    quitter            if q?(input)
  end

  def game_loop
    input               = gets.chomp.downcase
    cheater            if c?(input)
    quitter            if q?(input)
    end_game           if correct?(input)
    too_long           if input.length > 4
    too_short          if input.length < 4
    nice_try(input)    if wrong?(input)
  end

  def instructing_stuff
    puts "\nI'll generate a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. 
    Guess the four elements in the correct order to win. 
    Use (q)uit at any time to end the game.\n\n"
    intro
  end

  def start
    puts "\nI have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. 
    Use (q)uit at any time to end the game. What's your guess?\n\n"
    @timer_start = Time.now
    game_loop
  end

  def nice_try(input)
    @count += 1
    hints(0, input)
    puts "\nNot quite. Try again. You got #{@second_count} color(s) right.\n\n"
    @second_count = 0
    game_loop
  end

  def hints(n, input)
    return @second_count  if n > 3
    @second_count += 1    if input[n].eql? secret_answer[n]
    hints(n+1, input)
  end

  def end_game
    music
    end_game_set_up
    puts "\nWhoa, you actually did it? What a waste of time! It took you #{@count} tries in #{@minutes} minutes and #{@seconds} seconds.
    Would you like to (p)lay again or (q)uit?\n\n"
    input = gets.chomp
    quitter if q?(input)
    restart if play?(input)
  end

  def end_game_set_up
    puts "\n\n\n\n--------------------------------------------\n\n╔═╗  ╔═╗  ╔╗╔  ╔═╗  ╦═╗  ╔═╗  ╔╦╗  ╔═╗  ┬
║    ║ ║  ║║║  ║ ╦  ╠╦╝  ╠═╣   ║   ╚═╗  │
╚═╝  ╚═╝  ╝╚╝  ╚═╝  ╩╚═  ╩ ╩   ╩   ╚═╝  o

--------------------------------------------"
    @count += 1
    @timer_end = Time.now
    time = @timer_start - @timer_end
    @minutes = time.to_i/60; @minutes = 0 if @minutes < 1
    @seconds = 60 - time.to_i%60
  end

  def music
    music = Audite.new
    music.load('music.mp3')
    music.start_stream
  end
  
  def restart
    puts "\nGood luck...I have generated a beginner sequence with four elements made up of: 
    (r)ed, (g)reen, (b)lue, and (y)ellow. 
    Use (q)uit at any time to end the game. What's your guess?\n\n"
    @timer_start    = Time.now
    @count          = 0
    @secret_answer  = ["r", "g", "y", "b"].shuffle.join
    game_loop
  end

  def cheater
    @count += 1
    puts "\n#{secret_answer}...so what's your guess?\n\n"
    game_loop
  end

  def too_short
    @count += 1
    puts "\nThat's too few characters!\n\n"
    game_loop
  end

  def too_long
    @count += 1
    puts "\nThat's too many characters!\n\n"
    game_loop
  end

  def quitter
    puts "\nOK, later dude.\n\n"
    exit
  end

end

game_one = GameTime.new
game_one.intro