require 'spec_helper'

RSpec.describe 'rps server request' do
  it 'the paper should win' do
    threads = []
    expected_message = 'The winner move is paper'

    threads << Thread.new do
      RPSServer.new.start
    end

    threads << Thread.new do
      expect(play_rps('Pasha', 'rock')).to eq(expected_message)
    end

    threads << Thread.new do
      expect(play_rps('Vova', 'paper')).to eq(expected_message)
    end

    threads.each(&:join)
  end

  it 'the rock should win' do
    expected_message = 'The winner move is rock'
    threads = []

    threads << Thread.new do
      RPSServer.new.start
    end

    threads << Thread.new do
      sleep 0.5
      expect(play_rps('Pasha', 'rock')).to eq(expected_message)
    end

    threads << Thread.new do
      sleep 0.5
      expect(play_rps('Vova', 'scissors')).to eq(expected_message)
    end

    threads.each(&:join)
  end
end
