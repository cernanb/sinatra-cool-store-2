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

  describe 'class methods' do

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

	describe 'instance methods' do 
		describe 'checkout' do 
			it 'totals cart items and assigns to user.total spent' do
				# item1 = Item.create(name: 'iPhone', price: 250, inventory: 70)
      	# item2 = Item.create(name: 'XBox', price: 200, inventory: 10)

      	# @cart.items << item1
      	# @cart.items << item2
				# @user.total_spent = @cart.total
				expect(@user.total_spent).to eq(450)
			end
		 	it 'reduces inventory for each cart item' do
				qty = item2.qty
				expect(item2.quantity).to eq(qty-1	)
			end

			it 'updates cart status from pending to submitted' do
			
			end
		end
	end
end
