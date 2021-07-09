# frozen_string_literal: true

require 'socket'
require_relative 'rps'

# This class is used to start playing server
class RPSServer
  def initialize
    @threads = []
    @server = TCPServer.new(3939)
  end

  def start
    build_threads

    run_threads

    process_result

    send_result
  end

  private

  attr_reader :server, :threads

  def build_threads
    (1..2).each do |n|
      conn = server.accept # Wait for a client to connect

      threads << Thread.new(conn) do |cl| # argument 'conn' is passed to the block, perform actions with client
        Thread.current[:player] = cl # create for current thread 'player' variable with value: corresponding client
        cl.puts "Hey Player #{n}. What's your name?" # write to client 'Hey player...'
        name = cl.gets.chomp # retrieve the string from client's terminal and set it to name variable
        cl.puts "Hi. #{name}" # write to client  'Hi..*some_name*'
        cl.print 'Please type your move (rock, scissors or paper): ' # write to client message 'Please...'
        move = cl.gets.chomp
        Thread.current[:move] = move # create for current thread 'move'
        # variable wiht value: retrieved value from client's terminal

        cl.puts 'Please wait...' # write to client terminal 'Please wait...'
      end
    end
  end

  def run_threads
    threads.each(&:join)
  end

  def process_result
    player1 = RPS.new(threads[0].fetch(:move, 'error'))
    player2 = RPS.new(threads[1].fetch(:move, 'error'))
    @game_result = player1.play(player2)
  end

  def result
    case @game_result
    when :invalid_move
      'Error: One of the users wrote invalid move'
    when false
      'Tie'
    else
      "The winning move is #{@game_result.move}"
    end
  end

  def send_result
    threads.each { |thr| thr[:player].puts result }
    server.close
  end
end
