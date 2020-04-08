require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid with valid attributes" do
      category = Category.create(name: "Anything")
      product = Product.create(name: "Test", price: 12, quantity: 100, category: category)
      expect(product.errors.full_messages).to be_empty
    end

    it "is not valid without a name" do
      category = Category.new
      product = Product.new(price: 12, quantity: 100, category: category)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end

    it "is not valid without a price" do
      category = Category.new
      product = Product.new(name: "Test", quantity: 100, category: category)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end

    it "is not valid without a quantity" do
      category = Category.new
      product = Product.new(name: "Test", price: 12, category: category)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end
    
    it "is not valid without a category" do
      product = Product.new(name: "Test", price: 12, quantity: 100)
      product.save
      expect(product.errors.full_messages).not_to be_empty
    end
  end
end