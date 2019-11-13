require_relative "player"

class Game

  attr_reader :losses

  def initialize(*players)
    @players = players
    @losses = Hash.new(0)
    @fragment = ""
    dictionary = Hash.new(0)
    File.read("dictionary.txt").split("\n").each { |word| dictionary[word] += 1 }
    @dictionary = dictionary
  end

  def current_player
    @players.first
  end

  def previous_player
    @players.last
  end

  def next_player!
    @players.push(@players.shift)
  end

  def take_turn(player)
    input = player.guess
    until self.valid_play?(input)
        # self.losses
        p @fragment
        player.alert_invalid_guess
        input = player.guess
    end
    @fragment += input
  end

  def valid_play?(string)
    alphabet = ("a".."z")
    snippet = @fragment[0..-1] + string.downcase
    string.length == 1 && alphabet.include?(string.downcase) && @dictionary.keys.any? { |word| word.start_with?(snippet) }
  end

  def play_round
    puts @fragment
    current = self.current_player
    self.take_turn(current)
    current = self.next_player!
    self.add_loss
  end

  def add_loss
    if @dictionary.keys.any? { |word| @fragment == word }
      @losses[self.previous_player] += 1
      @fragment = ""
    end
  end

  def record(player)
    case @losses[player]
    when 1
      print "G"
    when 2
      print "GH"
    when 3
      print "GHO"
    when 4
      print "GHOS"
    when 5
      print "GHOST"
    end
  end

  def subtract_player
    @players.shift
  end

  def run
    until @players.length == 1
      p @losses
      self.play_round
      if @losses[previous_player] == 5
        self.subtract_player
      end
    end
  end

end

p1 = Player.new("Jon")
p2 = Player.new("Tina")
g = Game.new(p1, p2)
# g.play_round