require 'spec_helper'

RSpec.describe Message do
  it 'should return greeeting' do
    expect(Message.greeting('Dima')).to eq('Hi. Dima')
  end

  it 'should return tie' do
    expect(Message.tie).to eq('Tie')
  end

  it 'should return win' do
    winner = double('player', move: 'paper' )
    expect(Message.win(winner)).to eq('The winning move is paper')
  end

  it 'should return please wait' do
    expect(Message.please_wait).to eq('Please wait...')
  end

  it 'should return move question' do
    expect(Message.move_question).to eq('Please type your move (rock, scissors or paper): ')
  end

  it 'should return invalid move' do
    expect(Message.invalid_move).to eq('Error: One of the users wrote invalid move')
  end

  it 'should return name question' do
    expect(Message.name_question(1)).to eq('Hey Player 1. What\'s your name?')
  end
end
