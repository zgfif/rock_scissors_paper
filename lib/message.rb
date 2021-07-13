class Message
  class << self
    def win(winner)
      "The winning move is #{winner.move}"
    end

    def tie
      'Tie'
    end

    def invalid_move
      'Error: One of the users wrote invalid move'
    end

    def please_wait
      'Please wait...'
    end

    def name_question(n)
      "Hey Player #{n}. What's your name?"
    end

    def move_question
      'Please type your move (rock, scissors or paper): '
    end

    def greeting(name)
      "Hi. #{name}"
    end
  end
end
