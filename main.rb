# Personalized methods for the Enumerable module
module Enumerable
  def my_each
    return to_enum unless block_given?

    array = to_a
    array.size.times { |index| yield(array[index]) }

    self
  end

  def my_each_with_index
    return to_enum unless block_given?

    array = to_a
    array.size.times { |index| yield(array[index], index) }

    self
  end

  def my_select
    return to_enum(:select) unless block_given?

    array = to_a
    output_array = []

    array.my_each { |element| output_array << element if yield(element) }

    output_array = Hash[output_array.map { |key, value| [key, value] }] if self.class == Hash

    output_array
  end

  def my_all?(arg = nil)
    array = to_a

    if arg.nil?
      array.my_each { |element| return false unless element } unless block_given?

      array.my_each { |element| return false unless yield(element) } if block_given?

    elsif !arg.nil?
      array.my_each { |element| return false if !element.is_a?(String) || !element.match(arg) } if arg.is_a?(Regexp)

      array.my_each { |element| return false unless element.is_a?(arg) } if arg.is_a?(Class)

      array.my_each { |element| return false if element != arg } unless arg.is_a?(Class) || arg.is_a?(Regexp)
    end

    true
  end

  def my_any?(arg = nil)
    array = to_a

    if arg.nil?
      array.my_each { |element| return true if element } unless block_given?

      array.my_each { |element| return true if yield(element) } if block_given?

    elsif !arg.nil?

      array.my_each { |element| return true if element.is_a?(String) && element.match(arg) } if arg.is_a?(Regexp)

      array.my_each { |element| return true if element.is_a?(arg) } if arg.is_a?(Class)

      array.my_each { |element| return true if element == arg } unless arg.is_a?(Class) && arg.is_a?(Regexp)
    end

    false
  end

  def my_none?(arg = nil)
    array = to_a

    if arg.nil?
      array.my_each { |element| return false if element } unless block_given?

      array.my_each { |element| return false if yield(element) } if block_given?

    elsif !arg.nil?
      array.my_each { |element| return false if element.is_a?(String) && element.match(arg) } if arg.is_a?(Regexp)

      array.my_each { |element| return false if element.is_a?(arg) } if arg.is_a?(Class)

      array.my_each { |element| return false if element == arg } unless arg.is_a?(Class) && arg.is_a?(Regexp)
    end

    true
  end

  def my_count(arg = nil)
    array = to_a
    count = 0

    if arg.nil?
      block_given? ? array.my_each { |element| count += 1 if yield(element) } : array.my_each { count += 1 }
    else
      array.my_each { |element| count += 1 if element == arg }
    end

    count
  end

  def my_map(proc = nil)
    return to_enum(:map) unless block_given?

    array = to_a
    output_array = []

    array.my_each { |element| output_array << proc.call(element) } if proc
    array.my_each { |element| output_array << yield(element) } unless proc

    output_array
  end

  def my_inject(*arg)
    array = to_a
    arg1 = arg[0]
    arg2 = arg[1]

    both_args = arg1 && arg2
    only_one_arg = arg1 && !arg2
    no_arg = !arg1

    raise LocalJumpError if !block_given? && no_arg

    result = both_args || (only_one_arg && block_given?) ? arg1 : array.first

    if block_given?
      array.drop(1).my_each { |next_element| result = yield(result, next_element) } if no_arg

      array.my_each { |next_element| result = yield(result, next_element) } if only_one_arg

    else
      array.drop(1).my_each { |next_element| result = result.send(arg1, next_element) } if only_one_arg

      array.my_each { |next_element| result = result.send(arg2, next_element) } if both_args

    end
    result
  end
end

def multiply_els(array)
  raise ArgumentError('Only arrays with Numeric elements accepted') unless array.my_all?(Numeric)

  array.my_inject(:*)
end

# my_proc = proc { |num| num > 6 }
# p [2, 54, 6, 7].my_map(my_proc) { |num| num < 10 }

# p 5.times.my_inject(20, :*)
# p 5.times.inject(20, :*)
result = []
hash1 = { x: 1, y: 2 }
# p [1, 4, 1, nil].my_count(/^[A-Z]+$/i) { |el| el - 2 } 
# p 2.my_all?
# p 'xx'.my_all?
# p nil.my_all?
# p result

# p [1, 4, 6].my_all?() { |el| el > 2 }
# p [1, 4, 6].my_select { |el| el > 2 } 
p hash1.map { |element| element * 2 }