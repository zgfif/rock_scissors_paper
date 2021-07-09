# frozen_string_literal: true

class RPS
  include Comparable
  MOVES = %w[rock paper scissors].freeze
  COMBS = [%w[paper rock], %w[rock scissors], %w[scissors paper]].freeze

  attr_reader :move

  def initialize(move)
    @move = move.to_s
  end

  # this method return winning object of class RPS
  def play(other)
    if (!MOVES.include?(move)) || (!MOVES.include?(other.move))
      :invalid_move
    elsif self > other
      self
    elsif self < other
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
    else
      0
    end
  end
end
