require 'spec_helper'

describe ProductsController do

  let(:user) { FactoryGirl.create(:user) }
  let(:product) { FactoryGirl.create(:product) }
  let(:product1) { FactoryGirl.create(:product) }
  let(:product2) { FactoryGirl.create(:product) }
  let!(:showroom) { FactoryGirl.create(:showroom, :user => user, :products => [product]) }
  let(:current_showroom) { user.current_showroom }

  before do
    sign_in user
  end

  context "#index" do
    it "should render products" do
      get :index
      assigns(:products).should have(1).item
    end

    it "should not permit unauthorized user" do
      sign_out user
      get :index, :showroom_id => showroom
      assigns(:products).should be_nil
    end
  end

  context "#sort" do
    it "should find products" do
      xhr :post, :sort, :product => [product.id, product1.id, product2.id]
      assigns(:product).should_not be_nil
    end

    it "should not find products" do
      xhr :post, :sort, :product => []
      assigns(:product).should be_nil
    end

    it "should save position for product" do
      xhr :post, :sort, :product => [product.id, product1.id, product2.id]
      assigns(:product).position = 2
      assigns(:product).save
      assigns[:product].save.should == true
    end
  end

  context "#show" do
    it "should show product info" do
      get :show, :id => product
      assigns(:product).should eq(product)
    end

    it "should showr product info even if product doesn't belong to user's showroom" do
      public_product = FactoryGirl.create(:product)
      get :show, :id => public_product
      response.should be_success
      assigns(:product).should eq(public_product)
    end

    it "should not raise an error with invalid product id" do
      lambda {
        get :show, :showroom_id => showroom, :id => "invlid" 
      }.should_not raise_error
      response.should redirect_to(showroom_products_path)
    end


    it "should not permit unauthorized user" do
      sign_out user
      get :show, :showroom_id => showroom, :id => product
      assigns(:product).should be_nil
    end
  end

end
