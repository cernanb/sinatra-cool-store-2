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

  describe 'checkout' do
    before(:each) do
      @cart = Cart.create(status: 'pending')
      @item = @cart.items.create(name: 'iPhone', inventory: 20, price: 200)
      @item2 = @cart.items.create(name: 'xbox', inventory: 10, price: 250)
      @user = @cart.create_user(
        first_name: 'Cernan',
        last_name: "Bernardo",
        email: 'cernan@flatironschool.com')
    end

    it 'reduces the inventory for each item' do
      @cart.checkout

      expect(@item.inventory).to eq(19)
      expect(@item2.inventory).to eq(9)
    end

    it 'makes sure that the total spent by the user is updated' do
      @cart.checkout

      expect(@user.total_spent).to eq(450)
    end

    it 'changes the status of the cart to submitted' do
      @cart.checkout

      expect(@cart.status).to eq('submitted')
    end
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


end
