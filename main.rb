module Enumerable
  
  def my_each
    return to_enum unless block_given?

    array = to_a
    array.size.times { |index| yield(array[index]) }

    self
  end

  
end


# [1, 2, 4, 6].each { |element| p element * 3}
p [1, 2, 4, 6, 5].my_each