require_relative 'message'

class PlayerThread
  def initialize(connection, number)
    @connection = connection
    @number = number
  end

  def build
    Thread.new(connection) do |cl|
      cl.puts Message.name_question(number)
      name = cl.gets.chomp

      cl.puts Message.greeting(name)
      cl.print Message.move_question

      move = cl.gets.chomp

      Thread.current[:move] = move
      Thread.current[:player] = cl

      cl.puts Message.please_wait
    end
  end

  private

  attr :connection, :number
end
