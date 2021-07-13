# frozen_string_literal: true

require 'socket'
require_relative 'rps'
require_relative 'message'

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
      conn = server.accept # Wait for a client to connect

      threads << Thread.new(conn) do |cl| # argument 'conn' is passed to the block, perform actions with client
        Thread.current[:player] = cl # create for current thread 'player' variable with value: corresponding client
        cl.puts Message.name_question(n) # write to client 'Hey player...'
        name = cl.gets.chomp # retrieve the string from client's terminal and set it to name variable
        cl.puts Message.greeting(name) # write to client  'Hi..*some_name*'
        cl.print Message.move_question # write to client message 'Please...'
        move = cl.gets.chomp
        Thread.current[:move] = move # create for current thread 'move'
        # variable wiht value: retrieved value from client's terminal

        cl.puts Message.please_wait # write to client terminal 'Please wait...'
      end
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
    RPS.new(thread.fetch(:move, 'error'))
  end
end
