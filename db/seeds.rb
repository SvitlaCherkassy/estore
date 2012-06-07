require 'factory_girl_rails'

PASSWORD = "password"

def create_products
  15.times do
    product = FactoryGirl.create(:product, :price => rand(100)*10)
    p "created product - #{product.name}"
  end
end

def create_users
  p "--------------------  Created users: -------------------------"
  3.times do
    user = FactoryGirl.create(:user, :password => PASSWORD, :password_confirmation => PASSWORD)
    p "#{user.full_name} ( #{ user.email } )"

    p "------------------  Create user showroom  ------------------"
    showroom = FactoryGirl.create(:showroom, :user => user)
    p "showroom #{showroom.title} was created"

    p "------------------ Populating showroom with products -------"
    showroom.products << Product.order("RAND()").limit(10)
  end
end

def create_admins
  p "-" * 100
  admin = FactoryGirl.create(:admin_user, :password => PASSWORD, :password_confirmation => PASSWORD)
  p "Created Admin:"
  p "#{ admin.email }"
end

def create_pending_products
  p "Creating pendig products..."
  15.times do
    FactoryGirl.create(:product, :publish_at => Date.today + 1.month, :price => rand(100)*10)
  end
end

create_products
create_users
create_admins
create_pending_products
