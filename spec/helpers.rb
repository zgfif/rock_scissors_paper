# frozen_string_literal: true

require 'socket'

module Helpers
  def play_rps(name, move)
    conn = TCPSocket.open('localhost', 3939)
    conn.puts name, move # send player's name and move to the server
    3.times { conn.gets }
    game_result = conn.gets.chomp # retrieving the 4th server response
    conn.close

    game_result
  end
end
