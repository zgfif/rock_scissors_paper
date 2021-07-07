require_relative './lib/rps_server'

server = RPSServer.new(3939)
server.start
