class Admin::ProductsController < Admin::BaseController
  before_action :set_product, only: %i[edit update destroy]
  before_action :set_categories, only: %i[new edit]

  def index
    @products = Product.page(params[:page] || 1).per_page(params[:per_page] || 10).order('id desc')
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:notice] = '创建成功'
      redirect_to admin_products_path
    else
      set_categories
      render action: :new
    end
  end

  def edit
    render action: :new
  end

  def update
    if @product.update(product_params)
      flash[:notice] = '修改成功'
      redirect_to admin_products_path
    else
      render action: :new
    end
  end

  def destroy
    if @product.destroy
      flash[:notice] = '删除成功'
      redirect_to admin_products_path
    else
      flash[:notice] = '删除失败'
      redirect_to :back
    end
  end

  private

  def product_params
    params.require(:product).permit!
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def set_categories
    @root_categories = Category.roots.order('id desc')
  end
end
