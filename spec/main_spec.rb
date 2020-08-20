require_relative '../main.rb'

describe Enumerable do
  let(:array) { %w[cris john] }
  let(:hash) { { x: 1, y: 2 } }

  # describe '#my_each' do
  #   it 'returns an Enumerator if no block given' do
  #     expect([1, 4, 6].my_each.class).to be Enumerator
  #   end

  #   context 'returns a NoMethodError when' do
  #     it 'is called on a integer' do
  #       expect { 5.my_each { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on a string' do
  #       expect { 'XX'.my_each { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on nil' do
  #       expect { nil.my_each { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on boolean' do
  #       expect { true.my_each { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'the block cannot be applied to the containing elements' do
  #       expect { ['xx', nil, false].my_each { |el| el / 2 } }.to raise_error(NoMethodError)
  #     end
  #   end

  #   context 'returns the element that is called on:' do
  #     let(:block) { proc { |element| element } }

  #     it 'array when called on an array' do
  #       expect(array.my_each(&block)).to eql(array)
  #     end

  #     it 'hash when called on an hash' do
  #       expect(hash.my_each(&block)).to eql(hash)
  #     end
  #   end

  #   context 'yields the block on each element of the object is called on:' do
  #     it 'when array' do
  #       result = []
  #       array.my_each { |el| result.unshift(el) }
  #       expect(result).to eql(%w[john cris])
  #     end

  #     it 'when hash' do
  #       result = []
  #       hash.my_each { |el| result.push([el[0], el[1]]) }
  #       expect(result).to eql([[:x, 1], [:y, 2]])
  #     end
  #   end
  # end

  # describe '#my_each_with_index' do
  #   it 'returns an Enumerator if no block given' do
  #     expect([1, 4, 6].my_each_with_index.class).to be Enumerator
  #   end

  #   context 'returns a NoMethodError when' do
  #     it 'is called on a integer' do
  #       expect { 5.my_each_with_index { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on a string' do
  #       expect { 'XX'.my_each_with_index { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on nil' do
  #       expect { nil.my_each_with_index { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on boolean' do
  #       expect { true.my_each_with_index { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'the block cannot be applied to the containing elements' do
  #       expect { ['xx', nil, false].my_each_with_index { |el| el / 2 } }.to raise_error(NoMethodError)
  #     end
  #   end

  #   context 'returns the element that is called on:' do
  #     let(:block) { proc { |element| element } }

  #     it 'array when called on an array' do
  #       expect(array.my_each_with_index(&block)).to eql(array)
  #     end

  #     it 'hash when called on an hash' do
  #       expect(hash.my_each_with_index(&block)).to eql(hash)
  #     end
  #   end

  #   context 'yields the block on each element and its index of the object is called on:' do
  #     it 'when array received' do
  #       result = []
  #       array.my_each_with_index { |el, index| result.push([index, el]) }
  #       expect(result).to eql([[0, 'cris'], [1, 'john']])
  #     end

  #     it 'when hash received' do
  #       result = []
  #       hash.my_each_with_index { |el, index| result.push([index, el]) }
  #       expect(result).to eql([[0, [:x, 1]], [1, [:y, 2]]])
  #     end
  #   end
  # end

  # describe '#my_select' do
  #   it 'returns an Enumerator if no block given' do
  #     expect([1, 4, 6].my_select.class).to be Enumerator
  #   end

  #   context 'returns a NoMethodError when' do
  #     it 'is called on a integer' do
  #       expect { 5.my_select { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on a string' do
  #       expect { 'XX'.my_select { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on nil' do
  #       expect { nil.my_select { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'is called on boolean' do
  #       expect { true.my_select { |el| el } }.to raise_error(NoMethodError)
  #     end

  #     it 'the block cannot be applied to the containing elements' do
  #       expect { ['xx', nil, false].my_select { |el| el / 2 } }.to raise_error(NoMethodError)
  #     end
  #   end

  #   context 'returns the same class object that is called on:' do
  #     let(:block) { proc { |element| element } }

  #     it 'array when called on an array' do
  #       expect(array.my_select(&block).class).to be Array
  #     end

  #     it 'hash when called on an hash' do
  #       expect(hash.my_select(&block).class).to be Hash
  #     end
  #   end

  #   context 'yields the block an returns an object containing only the elements that pass:' do
  #     it 'when array received' do
  #       result = array.my_select { |el| el.length > 4 }
  #       expect(result).to eql([])
  #     end

  #     it 'when hash received' do
  #       result = hash.my_select { |_key, value| value > 1 }
  #       expect(result).to eql({ y: 2 })
  #     end
  #   end
  # end

  describe '#my_all?' do
    context 'returns a NoMethodError when' do
      it 'is called on a integer' do
        expect { 5.my_all? { |el| el } }.to raise_error(NoMethodError)
      end

      it 'is called on a string' do
        expect { 'XX'.my_all? { |el| el } }.to raise_error(NoMethodError)
      end

      it 'is called on nil' do
        expect { nil.my_all? { |el| el } }.to raise_error(NoMethodError)
      end

      it 'is called on boolean' do
        expect { true.my_all? { |el| el } }.to raise_error(NoMethodError)
      end

      it 'the block cannot be applied to the containing elements' do
        expect { ['xx', nil, false].my_all? { |el| el / 2 } }.to raise_error(NoMethodError)
      end
    end

    context 'if no parameter and block given' do
      it 'returns true if all elements are not `nil` or `false`' do
        expect([1, 4, 6].my_all?).to eql(true)
      end

      it 'returns false if one of the elements is `nil` or `false`' do
        expect([1, 4, nil].my_all?).to eql(false)
      end
    end

    context 'if parameter is received matches the parameter' do
      it 'if block given also, it only applies the parameter' do
        expect(array.my_all?(String) { |el| el.length < 2 }).to eql(true)
      end

      it 'if Regex match' do
        expect(array.my_all?(/^[A-Z]+$/i)).to eql(true)
      end

      it 'if Regex not match' do
        expect(array.my_all?(/x/)).to eql(false)
      end

      it 'if Class match' do
        expect(array.my_all?(String)).to eql(true)
      end

      it 'if Class not match' do
        expect(array.my_all?(Numeric)).to eql(false)
      end

      it 'if other type match' do
        expect([2, 2, 2].my_all?(2)).to eql(true)
      end

      it 'if other type not match' do
        expect(array.my_all?(2)).to eql(false)
      end
    end

    context 'when no paramter received, yields the block on each element and:' do
      it 'return true if all elements pass' do
        result = array.my_all? { |el| el.length == 4 }
        expect(result).to eql(true)
      end

      it 'return false if one element doesn`t pass' do
        result = array.my_all? { |el| el.length > 4 }
        expect(result).to eql(false)
      end

      context 'accepts hashes as well:' do
        it 'return true if all elements pass' do
          result = hash.my_all? { |_key, value| value > 0 }
          expect(result).to eql(true)
        end

        it 'return false if one element doesn`t pass' do
          result = hash.my_all? { |_key, value| value > 2 }
          expect(result).to eql(false)
        end
      end
    end
  end
end
