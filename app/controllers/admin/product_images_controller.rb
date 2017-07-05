class Admin::ProductImagesController < Admin::BaseController
  before_action :set_product

  def index
    @product_images = @product.product_images
  end

  def create
    params[:images]&.each do |image|
      product_image = ProductImage.new(image: image)
      product_image.product = @product
      product_image.save
      flash[:notice] = product_image.errors.full_messages unless product_image.errors.blank?
    end

    redirect_back fallback_location: admin_product_product_images_path(@product)
  end

  def destroy
    @product_image = @product.product_images.find(params[:id])
    flash[:notice] = if @product_image.destroy
                       '删除成功'
                     else
                       '删除失败'
                     end
    redirect_back fallback_location: admin_product_product_images_path(@product)
  end

  def update
    @product_image = @product.product_images.find(params[:id])
    flash[:notice] = if @product_image.update(weight: params[:weight])
                       '修改成功'
                     else
                       '修改失败'
                     end
    redirect_back fallback_location: admin_product_product_images_path(@product)
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end
end
