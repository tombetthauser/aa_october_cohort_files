class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :game_over, :seq

  def initialize
    @sequence_length = 1
    @game_over = false
    @seq = []
  end

  def play

  end

  def take_turn
    show_sequence
    require_sequence
  end

  def show_sequence
    self.seq
  end

  def require_sequence
    begin
      gets = input.chomp
      input # ?
    rescue StandardError
      retry
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def round_success_message

  end

  def game_over_message
    unless game_over p "The game is over!"
  end

  def reset_game
    @seq = sequence_length.times { add_random_color }
  end
end
