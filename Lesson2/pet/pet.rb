class Pet

  def initialize(name, type)
    @name = name
    @asleep = false
    @type = type
    @hp = 100
    @hungry_status = 15
    @sleep_status = 0
    @mood_status = rand(5..10)
    @clean_status = 0
    @is_sick = false
    puts "#{@type} #{@name} was born"
    puts "type 'help' if you want to see a list of all supported commands"
  end

  def start
    command = ''
    until command == 'exit'
      command = gets.chomp
      case command
        when 'help'
          help
        when 'feed'
          feed
        when 'walk'
          walk
        when 'sleep'
          put_to_bed
        when 'play'
          play
        when 'stroke'
          stroke
        when 'treat'
          treat
        when 'clean'
          clean
        when 'watch'
          puts 'How many hours?'
          h = gets.chomp.to_i
          watch(h)
        when 'help'
          help
        when 'exit'
          leave
        else
          puts "Wrong command, look for commands list typing 'help'"
      end
    end
  end

  def feed
    if poopy?
      puts "I'm fed now, and don't want to eat"
    else
      puts @name + ' is eating'
      @hungry_status += 3
      passage_of_time
    end
  end

  def walk
    puts @name + ' walking with you'
    @mood_status += 3
    passage_of_time
  end

  def put_to_bed
    puts @name + ' going to sleep'
    @asleep = true
    2.times do
      if @asleep
        passage_of_time
      end
    end
    sleep(3)
    @sleep_status = 0
    if @asleep
      @asleep = false
      puts @name + ' slowly wakes up.'
    end
  end

  def play
    if @is_sick
      puts "#{@name} don't want to play"
    else
      puts 'You playing with ' + @name
      @mood_status += 3
      passage_of_time
    end
  end

  def stroke
    puts 'You stroking a ' + @name
    puts '...purr, purr'
    passage_of_time
    if @asleep
      @asleep = false
      puts "...#{@name} awakening"
    end
  end

  def treat
    puts "You give #{@name} a medicine"
    @hp = 100
    @is_sick = false
    @mood_status = 2
    passage_of_time
  end

  def clean
    puts 'You bathe your pet'
    @clean_status = 0
    passage_of_time
  end

  def watch(hours)
    puts "Watch pet for #{hours} hours"
    hours.times do
      passage_of_time
    end
  end

  def help
    puts 'List of pet commands:'
    puts 'help - view list of all commands'
    puts 'feed - feed your pet'
    puts 'walk - walk with your pet outside'
    puts 'sleep - put your pet to bed'
    puts 'play - have fun with your pet'
    puts 'stroke - stroking or petting your pet'
    puts 'treat - give your pet a medicine'
    puts 'clean - bath your pet'
    puts 'watch - watch your pet for some hours'
    puts 'exit - leaving your pet'
  end

  def leave
    puts 'You leaving your pet'
    exit
  end

  private

  def hungry?
    @hungry_status <= 3
  end

  def poopy?
    @hungry_status >= 12
  end

  def dirty?
    @clean_status > 9
  end

  def sleepy?
    @sleep_status > 9 && !@asleep
  end

  def passage_of_time
    if @hungry_status > 0
      @hungry_status -= 1
    else
      if @asleep
        @asleep = false
        puts "#{@type} suddenly wakes up!"
      end
      puts @name + ' so hungry! In desperation, he runs away looking for food'
      exit
    end

    if hungry?
      if @asleep
        @asleep = false
        puts "#{@type} wakes up!"
      end
      puts 'I am very hungry!'
    end

    if @mood_status > 0
      @mood_status -= 1
    else
      @is_sick = true
      puts 'Your pet is in a bad mood'
      puts 'Your pet got sick'
    end

    if @is_sick
      @hp -= 2
      puts @name + ' is sick'
    end

    if sleepy?
      puts 'I very tired, I want to sleep'
    end

    if dirty?
      puts 'Your pet is very dirty'
    end

    if @hp <= 0
      puts "Sorry, but your pet #{@name} is dead"
    end
    @clean_status +=1
    @sleep_status +=1
  end

end

puts 'Enter a name of your pet'
name = gets.chomp
puts 'Enter a type of your pet (cat, dog, bird or other)'
type = gets.chomp

Pet.new(name, type).start