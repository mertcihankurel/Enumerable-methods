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
    #^no block and not argument
    return true
    elsif !arg.nil?
      warn "warning: given block not used" if block_given?
      array.my_each { |element| return false if element != arg }
      return true
    else
      array.my_each { |element| return false unless yield(element) } 
      return true
    end
    

  end

  
end

test_hash = {
  "x": 1,
  "Y": 2,
  "z": 3,
  "i": 2,
}

p ["g", "g", "y"].all?(/g/)
# p [1, 2, 4, 6, 5].my_each_with_index