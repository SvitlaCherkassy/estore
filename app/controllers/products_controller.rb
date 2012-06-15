class ProductsController < ApplicationController
  before_filter :authenticate_user!
  before_filter :find_product, :only => :show

  def index
    @products = Product.page(params[:page] || 1).order("products.position ASC")
  end

  def sort
    params[:product].each_with_index do |id, index|
      @product = Product.find(id)
      @product.position = index + 1
      @product.save
    end
    render :nothing => true
  end

  private

  def find_product
    # product is public thus it shouldn't be scoped with @showroom
    @product = Product.find_by_id(params[:id])
    redirect_to_default unless @product
  end

end
