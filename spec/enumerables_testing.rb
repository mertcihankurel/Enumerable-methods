require "../main.rb"

describe Enumerable do
    let(:test) {Enumerables.new}
    let(:my_array) {[1,3,5,7]}
    let(:my_string_array) {%w[Marc Luc Jean]}
    let(:my_numric_array) {[1, 5i, 5.67]}

    describe "#my_all?" do 
        it "Check if array pass all arguments" do
        expect(my_array.my_all?(3)).to eql(false)
        end
    end
end