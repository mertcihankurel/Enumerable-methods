# Personalized methods for the Enumerable module
module Enumerable
  def my_each(_arr = nil)
    return to_enum unless block_given?

    Array(self).length.times do |i|
      yield(Array(self)[i])
    end
    self
  end

  def my_each_with_index
    return to_enum(:my_each_with_index) unless block_given?

    Array(self).length.times do |index|
      yield(Array(self)[index], index)
    end
    self
  end

  def my_select
    return to_enum(:my_select) unless block_given?

    outcome = []
    my_each { |i| outcome.push(i) if yield(i) }
    outcome
  end

  def my_all?(arg = nil)
    if arg.nil? && !block_given?
      output = true
      my_each { |item| output = false if !item || item.nil? }
      output
    elsif block_given?
      outcome = true
      my_each { |item| outcome = false unless yield(item) }
      outcome
    elsif arg.is_a?(Class)
      outcome = true
      my_each { |item| outcome = false unless item.is_a?(arg) }
      outcome
    elsif arg.is_a?(Integer)
      outcome = true
      my_each { |item| outcome = false if item != arg }
      outcome
    elsif arg.is_a?(String) || arg.is_a?(Regexp)
      outcome = true
      my_each { |item| outcome = false unless item.match?(arg) }
      outcome
    end
  end

  def my_any?(arg = nil)
    if arg.nil? && !block_given?
      output = false
      my_each { |item| output = true if item && !item.nil? }
      output
    elsif block_given?
      outcome = false
      my_each { |item| outcome = true if yield(item) }
      outcome
    elsif arg.is_a?(Class)
      outcome = false
      my_each { |item| outcome = true if item.is_a?(arg) }
      outcome
    elsif arg.is_a?(Integer)
      outcome = false
      my_each { |item| outcome = true if item == arg }
      outcome
    elsif arg.is_a?(String) || arg.is_a?(Regexp)
      outcome = false
      my_each { |item| outcome = true if item.match?(arg) }
      outcome

    end
  end

  def my_none?(arg = nil)
    if arg.nil? && !block_given?
      output = true
      my_each { |item| output = false if item && !item.nil? }
      output
    elsif block_given?
      outcome = true
      my_each { |item| outcome = false if yield(item) }
      outcome
    elsif arg.is_a?(Class)
      outcome = true
      my_each { |item| outcome = false if item.is_a?(arg) }
      outcome
    elsif arg.is_a?(Integer)
      outcome = true
      my_each { |item| outcome = false if item == arg }
      outcome
    elsif arg.is_a?(String) || arg.is_a?(Regexp)
      outcome = true
      my_each { |item| outcome = false if item.match?(arg) }
      outcome
    end
  end

  def my_count(arg = nil)
    n = 0
    if block_given?
      my_each { |item| n += 1 if yield(item) }
    elsif arg.nil?
      n += 1 while n < size
    elsif arg.is_a?(Class)
      my_each { |item| n += 1 if item.is_a?(arg) }
    elsif arg.is_a?(Integer)
      my_each { |item| n += 1 if item == arg }
    else arg.is_a?(String)
         my_each { |item| n += 1 if item == arg || item.match?(arg) }
    end
    n
  end
  def my_map(arg = nil)
    if arg.nil?
      return to_enum unless block_given?

      output = []
      my_each { |item| output.push(yield(item)) }
      output
    elsif arg.class == Proc
      my_each { |item| Proc(item) if item }
    elsif arg.is_a?(Class)
      output = []
      my_each { |item| output.push(item) if item.is_a?(arg) }
      output
    elsif arg.is_a?(Integer)
      output = []
      my_each { |item| output.push(item) if item == arg }
      output
    else arg.is_a?(String)
         output = []
         my_each { |item| output.push(item) if item == arg || item.match?(arg) }
         output
    end
    output
  end

  def my_inject(*arg)
    raise('LocalJumpError.new NO BLOCK OR ARGUMENT GIVEN!') if !block_given? && arg == nil?

    check = false
    result = Array(self)[0]
    if (arg[0].class == Symbol) || arg[0].nil?
      check = true
    elsif arg[0].is_a? Numeric
      result = arg[0]
    end
    Array(self).my_each_with_index do |item, index|
      next if check && index.zero?

      if block_given?
        result = yield(result, item)
      elsif arg[0].class == Symbol
        result = result.send(arg[0], item)
      elsif arg[0].is_a? Numeric
        result = result.send(arg[1], item)
      end
    end
    result
  end

  def multiply_els(array)
    raise ArgumentError('Only arrays with Numeric elements accepted') unless array.my_all?(Numeric)

    array.my_inject(:*)
  end
end

def multiply_els(array)
  raise ArgumentError.new('Only arrays with Numeric elements accepted') unless array.my_all?(Numeric) # rubocop: disable Style/RaiseArgs

  array.my_inject(:*)
end

array = [5, 9, 10]
my_proc = proc { |num| num > 6 }
p [2, 54, 6, 7].my_map(my_proc) { |num| num < 10 }
p 5.times.my_inject(20, :*)
p 5.times.inject(20, :*)
p multiply_els(array)
