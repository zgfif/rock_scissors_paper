This is "rock scissors paper" game via terminal

To run game perform in Terminal:

``$ ruby lib/rps_server.rb``

Then open new tab in Terminal (to connect to server as the first player):

``$ telnet localhost 3939``

Then open another tab in Terminal and perform the same command (to connect as the second player):

``$ telnet localhost 3939``

Next, each player in corresponding tab enters his name and move (rock or scissors or paper).

After receiving a move of the second player, each player receives message with name of winner.

Run `$ bundle` to install the rspec gem (need for tests)

Then run ``$ rspec `` to perform rspec tests.
