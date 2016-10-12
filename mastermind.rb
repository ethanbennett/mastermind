require './lib/player-input'

class GameTime < PlayerInput
  attr_reader   :secret_answer
  attr_accessor :count
                :timer_start
                :second_count
  
  def initialize
    @secret_answer = ["r", "g", "y", "b"].shuffle.join
    @count         = 0
    @timer_start   = Time.now
    @second_count  = 0
  end

  def intro
    puts 'Welcome to MASTERMIND. Would you like to (p)lay, read the (i)nstructions, or (q)uit?'
    input = gets.chomp.downcase
    if play?(input)
      puts "I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. \nUse (q)uit at any time to end the game. What's your guess?"
      @timer_start = Time.now
      game_loop
    elsif instructions?(input)
      puts "I'll generate a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. \nGuess the four elements in the correct order to win. \nUse (q)uit at any time to end the game."
      intro
    elsif q?(input)
      puts "Whatever, you'd probably suck at this game anyway."
      return
    else
      puts "That doesn't look like a valid choice..."
      intro
    end
  end

  def hints(n, input)
    return @second_count if n > 3
    @second_count += 1 if input[n].eql? secret_answer[n]
    hints(n+1, input)
  end

  def end_game
      @count += 1
      timer_end = Time.now
      time = @timer_start - timer_end
      minutes = time.to_i/60; minutes = 0 if minutes < 1
      seconds = 60 - time.to_i%60
      puts "Whoa, you actually did it? What a waste of time! It took you #{count} tries in #{minutes} minutes and #{seconds} seconds.\nWould you like to (p)lay again or (q)uit?"
      input = gets.chomp
      if q?(input)
        puts "OK, later dude."
        return
      elsif play?(input)
        puts "Good luck...I have generated a beginner sequence with four elements made up of: (r)ed, (g)reen, (b)lue, and (y)ellow. \nUse (q)uit at any time to end the game. What's your guess?"
        @timer_start = Time.now
        @secret_answer = ["r", "g", "y", "b"].shuffle.join
        game_loop
      end
    end


  def game_loop
    input = gets.chomp.downcase
    if q?(input)
      puts "Whatever, you'd probably suck at this game anyway."
      return
    elsif c?(input)
      @count += 1
      puts "#{secret_answer}...so what's your guess?"
      game_loop
    elsif correct?(input)
      end_game
    elsif input.length > 4
      @count += 1
      puts "That's too many characters!"
      game_loop
    elsif input.length < 4
      @count += 1
      puts "That's too few characters!"
      game_loop
    elsif wrong?(input)
      @count += 1
      hints(0, input)
      puts "Not quite. Try again. You got #{@second_count} colors right."
      game_loop
    end
  end
end

game_one = GameTime.new
game_one.intro