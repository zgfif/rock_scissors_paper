# frozen_string_literal: true

require 'socket'
require_relative 'rps.rb'

class RPSServer
  def initialize(port)
    @threads = []
    @server = TCPServer.new(port)
  end

  def start
    build_threads

    run_threads

    process_winner

    send_result
  end

  private

  attr_reader :server, :threads, :winner

  def build_threads
    (1..2).each do |n|
        conn = server.accept  # Wait for a client to connect

        threads << Thread.new(conn) do |cl| # argument 'conn' is passed to the block, perform actions with client
          Thread.current[:player] = cl # create for current thread 'player' variable with value: corresponding client
          Thread.current[:number] = n  # create for current thread 'number' variable with value: corresponding n
          cl.puts "Hey Player #{n}. What's your name?" # write to client 'Hey player...'
          name = cl.gets.chomp # retrieve the string from client's terminal and set it to name variable
          cl.puts "Hi. #{name}" # write to client  'Hi..*some_name*'
          cl.print 'Please type your move (rock, scissors or paper): ' # write to client message 'Please...'
          move = cl.gets.chomp
          Thread.current[:move] = move #create for current thread 'move' variable wiht value: retrieved value from client's terminal

          cl.puts 'Please wait...' # write to client terminal 'Please wait...'
        end
    end
  end

  def run_threads
    threads.each(&:join)
  end

  def process_winner
    player_1 = RPS.new(threads[0].fetch(:move, 'error'))
    player_2 = RPS.new(threads[1].fetch(:move, 'error'))
    @winner = player_1.play(player_2)
  end

  def result
    winner ? winner.move : 'Tie'
  end

  def send_result
    threads.each { |thr| thr[:player].puts "The winner move is #{result}" }
    server.close
  end
end
