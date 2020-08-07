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
    if self.class == Hash
      output_array = Hash[output_array.map { |key, value| [key, value] }]
    end
    output_array
  end

  def my_all?(arg = nil)

    array = to_a
    if arg.nil? && !block_given?
      array.my_each { |element| return false if element.nil? || element == false}
    return true

    elsif !arg.nil?
      warn "warning: given block not used" if block_given?

      if arg.is_a(Regexp)
        array.my_each { |element| return false if !element.is_a?(String) || !element.match(arg) }
        return true
      elsif arg.is_a?(Class)
        input_array.my_each { |element| return false if !element.is_a?(arg) }
        return true
      else
        input_array.my_each { |element| return false if element != arg }
        return true
      end

    else
      array.my_each { |element| return false unless yield(element) }
      return true
    end
    true
  end

  def my_any?(arg = nil)
    array = to_a
    if arg.nil? && !block_given?
      array.my_each { |element| return true if element != nil && element != false}
    return false

    elsif !arg.nil?
      warn "warning: given block not used" if block_given?

      if arg.is_a?(Regexp)
        array.my_each { |element| return true if element.is_a?(String) && element.match(arg) }
        return false
      elsif arg.is_a?(Class)
        array.my_each { |element| return true if element.is_a?(arg) }
        return false
      else
        array.my_each { |element| return true if element == arg }
        return false
      end

    else
      array.my_each { |element| return true if yield(element) }
      return false
    end
    false
  end

  def my_none?(arg = nil)
    input_array = to_a
​
    if arg != nil
      warn "warning: given block not used" if block_given?

      if arg.is_a?(Regexp)
        input_array.my_each { |element| return false if element.is_a?(String) && element.match(arg) }
        return true
      elsif arg.is_a?(Class)
        input_array.my_each { |element| return false if element.is_a?(arg) }
        return true
      else
        input_array.my_each { |element| return false if element == arg }
        return true
      end
​
    elsif !block_given?
      input_array.my_each { |element| return false if element != nil && element != false }
      return true
    else
      input_array.my_each { |element| return false if yield(element) }
    end
​
    true
  end

  def my_count(arg = nil)
    input_array = to_a
    count = 0
​
    if arg != nil
      warn "warning: given block not used" if block_given?
      input_array.my_each { |element| count += 1 if element == arg }
    elsif !block_given?
      input_array.my_each { |element| count += 1 }
    else
      input_array.my_each { |element| count += 1 if yield(element) }
    end
​
    count
  end

  def my_map(&change_proc)
    return to_enum(:map) unless block_given?
    
    input_array = to_a
    output_array = []

    input_array.my_each { |element| output_array << yield(element) }

    output_array
  end

  def my_inject(*arg)
    array = to_a
    raise ArgumentError.new "wrong number of arguments (given #{arg.length}, expected 0..2)" if arg.length > 2
    raise LocalJumpError.new "no block given" if arg.length == 0 && !block_given?

    if arg.length == 2
      raise TypeError.new "#{arg.last} is not a symbol nor a string"
    if !arg.last.is_a?(Symbol) || !arg.last.is_a?(String)
      result = arg.first
      method = arg.last

      array.my_each { |next_element| result = result.send(method, next_element)}

      return result
    elsif arg.length == 1 && !block_given?
      raise TypeError.new "#{arg.first} is not a symbol nor a string" 
      if !arg.first.is_a?(Symbol) && !arg.first.is_a?(String)

      result = array.first
      method = arg.first
      array.my_each_with_index do |next_element, index|
        next if index.zero?

        result = result.send(method, next_element)
      end

      return result
    elsif arg.length == 1 && block_given?
      result = arg.first
      array.my_each { |next_element| result = yield(result, next_element) }
      return result
            else
      result = array.first

      array.my_each_with_index do |next_element, index|
        next if index.zero?

        result = yield(result, next_element)
      end

      result
        end
      end
    end

  def multiply_els(array)
    raise ArgumentError.new 'Only arrays with Numeric elements accepted' unless array.my_all?(Numeric)

  array.my_inject(:*)
  end
end
end
