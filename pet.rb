class Pet
  attr_accessor :animal, :name, :health, :bellyful, :peppiness,
                :mood, :purity, :toilet, :asleep, :response, :emoji, :stats

  def initialize(animal, name)
    @animal = animal
    @name = name
    @health = 100
    @bellyful = 100
    @peppiness = 100
    @mood = 100
    @purity = 100
    @toilet = 100
    @asleep = false
    @emoji = '&#128515;'
    @stats = [@health, @bellyful, @peppiness, @mood, @purity, @toilet]

    @response = []
    puts "У Вас появился #{@animal} #{@name}"
  end

  def feed
    @eating = true
    @bellyful = 100
    @response << (p 'Вы покормили питомца')
    pass_of_time
    @eating = false
  end

  def sleep
    if @peppiness > 75
      @response << (p 'Питомец не хочет спать')
      return
    end

    @asleep = true
    @response << (p 'Вы уложили питомца спать')
    3.times { pass_of_time if @asleep }
    @asleep = false
  end

  def play_with_pet
    @mood += 30
    @response << (p 'Вы поиграли со своим питомцем')
    pass_of_time
  end

  def toil
    @defecation = true
    @toilet = 100
    @response << (p 'Вы сводили питомца в туалет')
    pass_of_time
    @defecation = false
  end

  def bath
    @bathing = true
    @response << (p 'Вы покупали своего питомца')
    @purity = 100
    pass_of_time
    @bathing = false
  end

  def toss
    @mood += 15
    @response << (p 'Вы подбрасываете питомца')
    pass_of_time
  end

  def heal
    @health += 5
    @response << (p 'Вы даете питомцу витамины')
    pass_of_time
  end

  def sweets
    @bellyful += 20
    @eating = true
    @response << (p 'Вы угощаете питомца сладостями')
    pass_of_time
  end

  def rock
    @asleep = true
    @response << (p 'Вы укачиваете питомца')
    pass_of_time
    @asleep = false
  end

  def watch
    rand = rand(1..5)
    case rand
    when 1
      @peppiness += 15
      @response << (p 'Питомец пригрелся на солнышке')
    when 2
      @bellyful += 15
      @toilet -= 30
      @response << (p 'Питомец нашел и съел неспелые ягоды, это может привести к диарее')
    when 3
      @mood += 15
      @response << (p 'Питомец бегает за воробьем')
    when 4
      @purity -= 20
      @response << (p 'Питомец прыгает по лужам')
    end
    pass_of_time
  end

  def help
    p 'Список возможных команд:'
    p 'feed --- покормить'
    p 'sleep --- уложить спать'
    p 'play --- поиграть'
    p 'toilet --- сводить в туалет'
    p 'bath --- покупать'
    p 'info --- получить информацию о показателях питомца'
    p 'exit --- выйти с программы'
    p 'help --- получить список возможных команд'
    p 'toss --- подбрасывать питомца'
    p 'heal --- лечить питомца'
    p 'sweets --- угостить сладостями'
    p 'rock --- укачивать питомца'
    p 'watch --- наблюдать за питомцем'
  end

  def info
    puts "Здоровье   --- #{@health}%"
    puts "Сытость    --- #{@bellyful}%"
    puts "Бодрость   --- #{@peppiness}%"
    puts "Настроение --- #{@mood}%"
    puts "Чистота    --- #{@purity}%"
    puts "Туалет     --- #{@toilet}%"
  end

  private

  def pass_of_time
    if @asleep
      @peppiness += 25
      if @peppiness >= 100
        @peppiness = 100
        @asleep = false
        @response << (p 'Питомец просыпается выспавшийся')
      end
    else
      @peppiness -= rand(5..15)
      @peppiness = 0 if @peppiness.negative?
      if @peppiness.zero?
        @health -= rand(5..15)
        @mood -= 10
        @response << (p 'От усталости Ваш питомец уснул на ходу и упал ударившись головой')
        return @response << (p 'Ваш питомец получил травму головы') if @health <= 0

      elsif @peppiness <= 30
        @response << (p 'Глаза начинают слипаться')
      end
    end

    unless @defecation
      @toilet -= 10
      if @toilet <= 0
        @mood -= 10
        @purity -= 20
        @toilet = 100
        @response << (p 'Упс, питомец обделался')
      elsif @toilet <= 30
        @response << (p 'Ой, кажется питомец хочет в туалет')
      end
    end

    unless @bathing
      @purity -= 5
      @purity = 0 if @purity.negative?
      if @purity.zero?
        @mood -= 10
        @response << (p 'Ваш питомец весь в грязи, помойте его скорее!!!')
      elsif @purity <= 20
        @mood -= 5
        @response << (p 'Жуть какой грязный, пора мыться')
      elsif @purity <= 50
        @response << (p 'Уфф, замазался немного')
      end
    end

    unless @eating
      @bellyful -= rand(5..15)
      @bellyful = 0 if @bellyful.negative?
      if @bellyful.zero?
        @response << (p 'Ваш питомец мучается от голода')
        @health -= 5
        if @health <= 0
          @response << (p 'Длительное голодание не приводит ни к чему хорошему')
          return
        end
      elsif @bellyful <= 30
        @mood -= 5
        @response << (p 'В животе урчит')
      end
    end

    @mood = 100 if @mood > 100
    @mood = 0 if @mood.negative?
    if @mood <= 0
      @response << (p 'Ваш питомец очень расстроен, он ушел из дома...')
      if rand(0..2).positive?
        @mood = 30
        @response << (p '...Но вернулся, спустя несколько часов')
      else
        @emoji = '&#127748;'
        @response << (p '...навсегда')
        return
      end
    end
    @stats = [@health, @bellyful, @peppiness, @mood, @purity, @toilet]

    @emoji = if @stats.any? { |e| e <= 0 }
               '&#128546;'
             elsif @stats.any? { |e| e < 30 }
               '&#128532;'
             elsif @stats.any? { |e| e < 50 }
               '&#128528;'
             else
               '&#128515;'
             end

    # return unless @health <= 0
    #
    # @emoji = '☠'
    # @health = 0 if @health < 0
    # @response.clear << (p 'Ваш питомец умер')
    # # exit
  end
end
