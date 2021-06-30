# frozen_string_literal: true

require 'socket'
require_relative 'rps.rb'

threads = [] # initialization array of threads

server = TCPServer.new(3939) #bind server to port 3939


# 2 times perform processing of new connection
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
    puts ''
    cl.puts "Your typed: #{move} mo d"
    Thread.current[:move] = move #create for current thread 'move' variable wiht value: retrieved value from client's terminal

    cl.puts 'Please wait...' # write to client terminal 'Please wait...'
  end
end

a, b = threads # assign 2 threads from array of threads to 'a' and 'b' corresponding variables
a.join # allow 'a' thread to act
b.join # allow 'b' thread to act

first_p = RPS.new(a.fetch(:move, 'error')) # return the 'move' key from a thread, if no key returns 'error' and initialize as move of the first player
second_p = RPS.new(b.fetch(:move, 'error')) # return the 'move' key from b thread, if no key returns 'error' and initialize as move of the second player

winner = first_p.play second_p # retrieve a winner between player_a and player_b

result = if winner  # if we have winner assign winner's move to 'result' else assign 'Tie' to result
           winner.move
         else
           'Tie'
         end

threads.each do |thr| # for each thread (first and second thread)
  thr[:player].puts "The winner move is #{result}" # send 'The winner...' to corresponding client in player
end

server.close # terminate server
