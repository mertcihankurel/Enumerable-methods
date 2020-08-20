require_relative '../main.rb'

describe Enumerable do
  let(:array) { %w[cris john] }
  let(:hash) { { x: 1, y: 2 } }

  describe '#my_each' do
    it 'returns an Enumerator if no block given' do
      expect([1, 4, 6].my_each.class).to be Enumerator
    end

    context 'returns a NoMethodError when' do
      it 'is called on a integer' do
        expect { 5.my_each { |el| el } }.to raise_error(NoMethodError)
      end

      it 'is called on a string' do
        expect { 'XX'.my_each { |el| el } }.to raise_error(NoMethodError)
      end

      it 'is called on nil' do
        expect { nil.my_each { |el| el } }.to raise_error(NoMethodError)
      end

      it 'is called on boolean' do
        expect { true.my_each { |el| el } }.to raise_error(NoMethodError)
      end

      it 'the block cannot be applied to the containing elements' do
        expect { ['xx', nil, false].my_each { |el| el / 2 } }.to raise_error(NoMethodError)
      end
    end

    context 'returns the element that is called on:' do
      let(:block) { proc { |element| element } }

      it 'array when called on an array' do
        expect(array.my_each(&block)).to eql(array)
      end

      it 'hash when called on an hash' do
        expect(hash.my_each(&block)).to eql(hash)
      end
    end

    context 'yields the block on each element of the object is called on:' do
      it 'when array' do
        result = []
        array.my_each { |el| result.unshift(el) }
        expect(result).to eql(%w[john cris])
      end

      it 'when hash' do
        result = []
        hash.my_each { |el| result.push([el[0], el[1]]) }
        expect(result).to eql([[:x, 1], [:y, 2]])
      end
    end
  end

end
