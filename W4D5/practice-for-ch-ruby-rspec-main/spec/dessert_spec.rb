require 'rspec'
require 'dessert'

=begin
Instructions: implement all of the pending specs (the `it` statements without blocks)! Be sure to look over the solutions when you're done.
=end

describe Dessert do
  let(:chef) { double("chef") name: 'Gordon Ramsey' }
  subject(:dessert_1){Dessert.new('brownie', 2, chef)}

  describe "#initialize" do
    it "sets a type" do
      expect(dessert_1.type).to eq('brownie')
    end

    it "sets a quantity" do
      expect(dessert_1.quantity).to eq(2)
    end

    it "starts ingredients as an empty array" do
      expect(dessert_1.instance_variable_get(:ingredients)).to eq([])
    end

    it "raises an argument error when given a non-integer quantity" do
      expect{Dessert.new('brownie', '2', 'gordon ramsey')}.to raise_error(ArgumentError)
    end
  
  end

  describe "#add_ingredient" do
    it "adds an ingredient to the ingredients array" do
      dessert_1.add_ingredient('spinach')
      expect(dessert_1.ingredients).to include('spinach')
    end
  end

  describe "#mix!" do
    it "shuffles the ingredient array" do
      ingredients = ["chocolate", "flour", "egg", "sugar", "butter"]

      ingredients.each do |ingredient|
        brownie.add_ingredient(ingredient)
      end

      expect(brownie.ingredients).to eq(ingredients)
      brownie.mix!
      expect(brownie.ingredients).not_to eq(ingredients)
      expect(brownie.ingredients.sort).to eq(ingredients.sort)
    end

  end

  describe "#eat" do
    dessert_1.eat(1)
    it "subtracts an amount from the quantity" do
      expect(dessert_1.quantity).to eq(1)
    end

    it "raises an error if the amount is greater than the quantity" do
      expect(dessert_1.eat(30)).to raise_error("Not enough left!")
    end

  end

  describe "#serve" do
    it "contains the titleized version of the chef's name" do
      expect(chef).to recieve(:titleize).and_return("Gordon Ramsey")
      expect(dessert_1.serve).to eq("Gordon Ramsey has made 2 brownies!")
    end
  end

  describe "#make_more" do
    it "calls bake on the dessert's chef with the dessert passed in" do
      expect(chef).to_recieve(:bake).with(dessert_1)
      dessert_1.make_more
    end
  end
end