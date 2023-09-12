class Board
  attr_accessor :cups

  def initialize(name1, name2)
    @cups = Array.new(14){Array.new}
    self.place_stones
  end

  def place_stones
    # helper method to #initialize every non-store cup with four stones each
    (0..13).each do |i|
      unless i == 6 || i == 13
        4.times do 
          cups[i] << :stone
        end
      end
    end
  end

  def valid_move?(start_pos)
    raise "Invalid starting cup" if start_pos > 14
    raise 'Starting cup is empty' if cups[start_pos].empty?
  end

  def make_move(start_pos, current_player_name)
    cup_count = cups[start_pos].length
    p cup_count
    cups[start_pos].clear()
    (start_pos...start_pos+cup_count).each do |i|

    end

    self.render
  end

  def next_turn(ending_cup_idx)
    # helper method to determine what #make_move returns
  end

  def render
    print "      #{@cups[7..12].reverse.map { |cup| cup.count }}      \n"
    puts "#{@cups[13].count} -------------------------- #{@cups[6].count}"
    print "      #{@cups.take(6).map { |cup| cup.count }}      \n"
    puts ""
    puts ""
  end

  def one_side_empty?
    return true if cups[0..5].all?{|cup| cup.empty?}
    return true if cups[7..12].all?{|cup| cup.empty?}
    return false if cups[0..5].none?{|cup| cup.empty?} && cups[7..12].none?{|cup| cup.empty?}
  end

  def winner
    if cups[6] == cups[13]
      return :draw 
    elsif cups[6].length > cups[13].length
      return @player1.name
    else
      return @player2.name
    end
  end
end

b = Board.new("rob", "reb")
b.make_move(0, "rob")
