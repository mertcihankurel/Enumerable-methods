class Animal
  def speak
    "Animals don`t speak!"
  end
end

class Dog < Animal
  attr_accessor :name

  def initialize(n)
    @name = n
  end

  def speak
    super + " But #{@name} says Bark Bark"
  end
end

class Cat < Animal
  def speak
    puts "Miaouuu"
  end
end

dog = Dog.new("Cristian")
cat = Cat.new

puts dog.speak
puts cat.speak