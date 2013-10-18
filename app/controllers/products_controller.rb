class ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def show
    if Product.exists?(params[:id])
      @product = Product.find(params[:id])
      @comments = @product.comments.all
      @comment = @product.comments.new
    end
  end

  def new
    @product = Product.new
  end

  def edit
    if Product.exists?(params[:id])
      @product = Product.find(params[:id])
    else
      redirect_to "/products", notice: 'Product ' +params[:id].to_s+ ' does not exist!'
    end
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to "/products/"+@product.id.to_s, notice: 'Product ' +@product.id.to_s+ ' has been successfully created!'
    else
      render action: "new" 
    end
  end

  def update

    @product = Product.find(params[:id])
    newParams = {}

    if params['product']['name']!= ""
      newParams['name'] = params['product']['name']
    end

    if params['product']['description']!= ""
      newParams['description'] = params['product']['description']
    end

    if params['product']['pricing']!= ""
      newParams['pricing'] = params['product']['pricing']
    end

    if params['product']['category']!= ""
      newParams['category_id'] = params['product']['category_id']
    end

    if @product.update(newParams)
      redirect_to "/products/"+@product.id.to_s, notice: 'Product has been updated'
    else
      render action: "edit", notice: 'Edit failed'
    end
  end

  def destroy
    @product = Product.find(params[:id])

    if @product.destroy
      redirect_to "/products", notice: 'Product ' +@product.id.to_s+ ' has been deleted'
    else
      redirect_to "/products", notice: 'Product ' +@product.id.to_s+ ' has not been deleted'
    end
  end

  private
  def product_params
    params.require(:product).permit(:name, :description, :category_id, :pricing)
  end
end
