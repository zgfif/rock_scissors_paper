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
end
