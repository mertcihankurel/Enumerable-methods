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


end

test_hash = {
  "x": 1,
  "Y": 2,
  "z": 3,
  "i": 2,
}

p [1, 2, 5, 67].my_any?(Float)

# p [1, 2, 4, 6, 5].my_each_with_index