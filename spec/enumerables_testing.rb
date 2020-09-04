require '../main.rb'

describe Enumerable do
  let(:test) { Enumerables.new }
  let(:my_array) { [1, 3, 5, 7] }
  let(:my_string_array) { %w[Marc Luc Jean] }
  let(:my_numric_array) { [1, 5i, 5.67] }

  describe '#my_each' do
    result = []
    it 'array when called on an array' do
      my_array.my_each_with_index { |n| result.push(n + 2) }
      expect(result).to eql([3, 5, 7, 9])
    end
  end
  describe '#my_each_with_index' do
    result = []
    it 'element and index when called on an array' do
      [3].my_each_with_index { |n, g| result.push("#{n} + #{g}") }
      expect(result).to eql(['3 + 0'])
    end
  end

  describe '#my_all?' do
    it 'Check if array pass all arguments' do
      expect(my_array.my_all?).to eql(true)
    end
    it 'Check if array pass all arguments' do
      expect(my_array.my_all?(3)).to eql(false)
    end
    it 'Check if array pass all arguments' do
      expect(my_array.my_all? { |n| n == 3 }).to eql(false)
    end
  end

  describe '#my_any?' do
    it 'Check if array is any of the passed arguments' do
      expect(my_array.my_any?).to eql(true)
    end

    it 'Check if array is any of the passed arguments' do
      expect(my_array.my_any?(3)).to eql(true)
    end

    it 'Check if array is any of the passed arguments' do
      expect(my_array.my_any? { |n| n == 3 }).to eql(true)
    end
  end

  describe '#my_none?' do
    it 'Check if array has none of the passed arguments' do
      expect(my_array.my_none?).to eql(false)
    end
    it 'Check if array has none of the passed arguments' do
      expect(my_array.my_none?(3)).to eql(false)
    end
    it 'Check if array has none of the passed arguments' do
      expect(my_array.my_none? { |n| n == 3 }).to eql(false)
    end
  end

  describe '#my_select' do
    it 'outputs an array of selected arguments from the array which is called on' do
      expect(my_array.my_select { |n| n.odd? }).to eql(my_array)
    end
    it 'outputs an array of selected arguments from the array which is called on' do
      expect(my_array.my_select).to be # <Enumerator: ...>
    end
  end
  describe '#my_count' do
    it 'count the elements of given array' do
      expect(my_array.my_count).to eql(4)
    end
    it 'count the elements of given array' do
      expect(my_array.my_count(3)).to eql(1)
    end
    it 'count the elements of given array' do
      expect(my_array.my_count { |n| n == 3 }).to eql(1)
    end
  end
  describe '#my_map' do
    proc = proc { |element| element }
    it 'Check if array pass any arguments' do
      expect(my_array.my_map).to be # <Enumerator: ...>
    end
    it 'Check if array pass any arguments' do
      result = []
      my_array.my_map { |n| result.push(n += 2) }
      expect(result).to eql([3, 5, 7, 9])
    end
    it 'Check if array pass any arguments' do
      expect(my_array.my_map(&proc)).to eql(my_array)
    end
  end
  describe '#my_inject' do
    proc = proc { |n, g| n * g }
    it 'does a selected operation on array elements given from an argument, proc, or a block' do
      expect(my_array.my_inject).to be # <Enumerator: ...>
    end
    it 'does a selected operation on array elements given from an argument, proc, or a block' do
      expect(my_array.my_inject { |n, g| n * g }).to eql(105)
    end
    it 'does a selected operation on array elements given from an argument, proc, or a block' do
      expect(my_array.my_inject(:*)).to eql(105)
    end
    it 'does a selected operation on array elements given from an argument, proc, or a block' do
      expect(my_array.my_inject(&proc)).to eql(105)
    end
  end
  describe '#multiply_els' do
    it 'returns the elements of the given array multiplied' do
      expect(multiply_els(my_array)).to eql(105)
    end
  end
end
