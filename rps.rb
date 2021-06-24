# frozen_string_literal: true

class RPS
  include Comparable

  COMBS = [%w[paper rock], %w[rock scissors], %w[scissors paper]].freeze

  attr_reader :move

  def initialize(move)
    @move = move.to_s
  end

  def <=>(other)
    if COMBS.include?([move, other.move])
      1
    elsif COMBS.include?([other.move, move])
      -1
    elsif move == other.move
      0
    end
  end

  def play(other)
    if self > other
      self
    elsif other > self
      other
    else
      false
    end
  end
end
p RPS::COMBS
# r1 = RPS.new('scissors')
# r2 = RPS.new('rock')
# # p r1 > r2
# winner = r1.play r2
# puts winner.move
