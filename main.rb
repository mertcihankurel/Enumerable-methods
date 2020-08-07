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
  
end



[1, 2, 4, 6].my_each_with_index { |element, index| p "#{element} * #{index}"}
# p [1, 2, 4, 6, 5].my_each_with_index