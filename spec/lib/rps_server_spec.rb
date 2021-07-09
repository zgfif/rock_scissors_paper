require 'spec_helper'

RSpec.describe 'rps server request' do
  it 'the paper should win rock' do
    threads = []
    expected_message = 'The winning move is paper'

    threads << Thread.new { RPSServer.new.start }

    threads << Thread.new do
      expect(play_rps('Pasha', 'rock')).to eq(expected_message)
    end

    threads << Thread.new do
      expect(play_rps('Vova', 'paper')).to eq(expected_message)
    end

    threads.each(&:join)
  end

  it 'the rock should win scissors' do
    expected_message = 'The winning move is rock'
    threads = []

    threads << Thread.new { RPSServer.new.start }

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

  it 'the scissors should win paper' do
    expected_message = 'The winning move is scissors'
    threads = []

    threads << Thread.new { RPSServer.new.start }

    threads << Thread.new do
      sleep 0.5
      expect(play_rps('Pasha', 'paper')).to eq(expected_message)
    end

    threads << Thread.new do
      sleep 0.5
      expect(play_rps('Vova', 'scissors')).to eq(expected_message)
    end

    threads.each(&:join)
  end

  it 'should be tie' do
    expected_message = 'Tie'
    threads = []

    threads << Thread.new { RPSServer.new.start }

    threads << Thread.new do
      sleep 0.5
      expect(play_rps('Pasha', 'paper')).to eq(expected_message)
    end

    threads << Thread.new do
      sleep 0.5
      expect(play_rps('Vova', 'paper')).to eq(expected_message)
    end

    threads.each(&:join)
  end
end
