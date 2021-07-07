require 'spec_helper'

RSpec.describe 'rps server request' do
  it 'should return winning move (paper) to each player' do
    threads = []

    threads << Thread.new do
      server = RPSServer.new(3939)
      server.start
    end

    threads << Thread.new do
      expect(play_rps('Pasha', 'rock', 3939)).to eq('The winner move is paper')
    end

    threads << Thread.new do
      expect(play_rps('Vova', 'paper', 3939)).to eq('The winner move is paper')
    end

    threads.each { |thread| thread.join }
  end

  xit 'should return winning move (paper) to each player' do
    threads = []

    threads << Thread.new do
      server = RPSServer.new(3940)
      server.start
    end

    threads << Thread.new do
      expect(play_rps('Pasha', 'rock', 3940)).to eq('The winner move is paper')
    end

    threads << Thread.new do
      expect(play_rps('Vova', 'paper', 3940)).to eq('The winner move is paper')
    end

    threads.each { |thread| thread.join }
  end
end
