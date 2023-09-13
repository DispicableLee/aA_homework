class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play
    # until game is over
    until !take_turn
      self.take_turn
    end
    # when game is over
    game_over_message
    reset_game
  end

  def take_turn
    show_sequence
    if require_sequence == @seq
      round_success_message
      sequence_length+=1
      return true
    end
    false
  end

  def show_sequence
    self.add_random_color
    @seq
  end

  def require_sequence
    p "enter the color sequence"
    res = gets.chomp.split(" ")
  end

  def add_random_color
    seq << COLORS.sample
  end

  def round_success_message
    p 'You have won this round!'
  end

  def game_over_message
    p 'you suck loser'
  end

  def reset_game
    @sequence_length= 1
    @game_over = false
    @seq = []
  end
end

