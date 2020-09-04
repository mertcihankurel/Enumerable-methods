require "../main.rb"

describe Enumerable do
    let(:test) {Enumerables.new}
    let(:my_array) {[1,3,5,7]}
    let(:my_string_array) {%w[Marc Luc Jean]}
    let(:my_numric_array) {[1, 5i, 5.67]}

    describe '#my_all?' do 
        it "Check if array pass all arguments" do
        expect(my_array.my_all?(3)).to eql(false)
        end
    end

    describe '#my_any?' do
        it "Check if array pass any arguments" do
        expect(my_array.my_any?(3)).to eql(true)
        end
    end

    describe '#my_none?' do
        it "Check if array pass any arguments" do
        expect(my_array.my_none?(3)).to eql(false)
        end
    end

    describe '#my_select' do
        it "Check if array pass any arguments" do
        expect(my_array.my_select {|n| n.odd?}).to eql(my_array)
        end
    end
end