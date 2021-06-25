# frozen_string_literal: true

class RPS
  include Comparable

  COMBS = [%w[paper rock], %w[rock scissors], %w[scissors paper]].freeze

  attr_reader :move

  def initialize(move)
    @move = move.to_s
  end

  # this method return winning object of class RPS
  def play(other)
    if self > other
      self
    elsif other > self
      other
    else
      false
    end
  end

  private

  def <=>(other)
    if COMBS.include?([move, other.move])
      1
    elsif COMBS.include?([other.move, move])
      -1
    elsif move == other.move
      0
    end
  end
end
