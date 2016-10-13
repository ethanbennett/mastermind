class PlayerInput
  def initialize
  end
  
  def q?(input)
    input == "q"
  end

  def c?(input)
    input == "c"
  end

  def correct?(input)
    input == secret_answer
  end

  def wrong?(input)
    input != secret_answer
  end

  def instructions?(input)
    input == "i"
  end

  def play?(input)
    input == "p"
  end

  def huh?(input)
    input != "q"; input != "p"; input != "i"
  end
end
