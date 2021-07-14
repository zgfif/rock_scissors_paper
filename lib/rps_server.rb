# frozen_string_literal: true

require 'socket'
require_relative 'rps'
require_relative 'message'
require_relative 'player_thread'

# This class is used to start playing server
class RPSServer
  def initialize
    @threads = []
    @server = TCPServer.new(3939)
  end

  def start
    build_threads
    run_threads
    game_result
    send_message
    terminate_server
  end

  private

  attr_reader :server, :threads

  def build_threads
    (1..2).each do |n|
      threads << PlayerThread.new(server.accept, n).build
    end
  end

  def run_threads
    threads.each(&:join)
  end

  def game_result
    @game_result ||= first_player.play(second_player)
  end

  def message
    case game_result
    when :invalid_move
      Message.invalid_move
    when false
      Message.tie
    else
      Message.win(game_result)
    end
  end

  def first_player
    player(threads[0])
  end

  def second_player
    player(threads[1])
  end

  def send_message
    threads.each { |thr| thr[:player].puts message }
  end

  def terminate_server
    server.close
  end

  def player(thread)
    RPS.new(thread[:move])
  end
end
