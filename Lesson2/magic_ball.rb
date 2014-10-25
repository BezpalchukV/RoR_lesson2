class MagicBall

  def initialize
    @answers = IO.readlines('answers.txt')
    @array_length = @answers.length
  end

  def get_question
    puts 'Ask me a yes-no question'
    gets.chomp
  end

  def shake
    puts "Wait a moment please, I'm thinking..."
    sleep(3)
    @answers[rand(@array_length)]
  end

end

ball = MagicBall.new
ball.get_question
puts ball.shake