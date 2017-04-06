require_relative '../spec_helper'

describe Cart do
	before(:each) do
		@cart = Cart.create
	end

	it 'is created with a default status of pending' do
		expect(@cart.status).to eq('pending') 
	end

	it 'knows if its status has changed' do
		@cart.status = 'submitted'

		expect(@cart.status).to eq('submitted')
	end

  describe 'instance methods' do

    describe 'total' do
      let(:cart) {Cart.create}
      let(:item) {Item.create(name: 'iPhone', price: 250, inventory: 70)}
      let(:item2) {Item.create(name: 'XBox', price: 200, inventory: 10)}

      it 'returns 0 if there are no items in the cart' do
        expect(cart.total).to eq(0)
      end

      it 'returns the total of the items in the cart' do
        cart.items << item
        cart.items << item2

        expect(cart.total).to eq(450)
      end
    end

		describe 'checkout' do 
      let(:user) {User.create(first_name: "Charlie", last_name: "Bernardo", email: "cernan@flatironschool.com", total_spent: 1)}
      let(:cart) {Cart.create(user_id: user.id)}
      let(:item) {Item.create(name: 'iPhone', price: 250, inventory: 70)}
      let(:item2) {Item.create(name: 'XBox', price: 200, inventory: 3)}

      it 'adds cart total to user total_spent' do
        cart.items << item
        cart.items << item2
				cart.checkout

        expect(cart.user.total_spent.to_i).to eq(451)
      end

			it 'reduces inventory for each cart item' do
				cart.items << item
				cart.items << item2
				cart.checkout

				expect(item2.inventory).to eq(2)
			end

			it 'updates cart status from pending to submitted' do
			cart.checkout
			
			expect(cart.status).to eq("submitted")
			end
		end
	end

  describe 'associations' do
    
		it 'belongs to a user' do
      @cart = Cart.create
      user = User.create(last_name: "Bernardo", email: "cernan@flatironschool.com")
      user.carts << @cart

      expect(@cart.user).to eq(user)
    end

    it 'has many items' do
      item1 = Item.create(name: 'iPhone', price: 250, inventory: 70)
      item2 = Item.create(name: 'XBox', price: 200, inventory: 10)

      @cart.items << item1
      @cart.items << item2

      expect(@cart.items.size).to eq(2)
    end
  end
end