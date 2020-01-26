# frozen_string_literal: true

require 'socket'
require_relative 'rps.rb'
threads = []
server = TCPServer.new(3939)

(1..2).each do |n|
  conn = server.accept
  threads << Thread.new(conn) do |cl|
    Thread.current[:player] = cl
    Thread.current[:number] = n
    cl.puts "Hey Player #{n}. What's your name?"
    name = cl.gets.chomp
    cl.puts "Hi. #{name}"
    cl.print 'Please type your move (rock, scissors or paper): '
    Thread.current[:move] = cl.gets.chomp

    cl.puts 'Please wait...'
  end
end

a, b = threads
a.join
b.join

first_p = RPS.new(a.fetch(:move, 'error'))
second_p = RPS.new(b.fetch(:move, 'error'))

winner = first_p.play second_p

result = if winner
           winner.move
         else
           'Tie'
         end

threads.each do |thr|
  thr[:player].puts "The winner move is #{result}"
end
server.close
