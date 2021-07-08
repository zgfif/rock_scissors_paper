require 'socket'

module Helpers
  def play_rps(name, move)
    terminal = TCPSocket.open('localhost', 3939)
    terminal.puts name # send player's name to the server
    terminal.puts move # send player's move to the server
    terminal.gets
    terminal.gets
    terminal.gets
    fourth_response = terminal.gets # retrieving the 4th server response
    terminal.close

    fourth_response.chomp
  end
end
