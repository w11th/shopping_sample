class CreateProductImages < ActiveRecord::Migration[5.1]
  def change
    create_table :product_images do |t|
      t.references :product, foreign_key: true
      t.integer :weight, default: 0
      # paperclip iamge_*
      t.attachment :image
      t.timestamps
    end
  end
end
