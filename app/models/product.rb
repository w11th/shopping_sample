class Product < ApplicationRecord
  validates_uniqueness_of :uuid
  validates :title, presence: { message: '名称不能为空' }
  validates :category_id, presence: { message: '类别不能为空' }
  validates :status, inclusion: { in: %w[on off], message: '商品状态必须为 on 或 off' }
  validates :amount, presence: { message: '库存不能为空' }
  validates :amount, numericality: { only_integer: true, message: '库存必须为整数' }, allow_blank: true
  validates :msrp, presence: { message: 'MSRP 不能为空' }
  validates :msrp, numericality: { message: 'MSRP 必须为数字' }, if: proc { |product| !product.msrp.blank? }
  validates :description, presence: { message: '描述不能为空' }

  belongs_to :category
  has_many :product_images, -> { order('weight desc') }, dependent: :destroy

  has_one :main_product_image, -> { order(weight: 'desc') }, class_name: :ProductImage

  before_create :set_default_attrs

  scope :onshelf, -> { where(status: 'on') }

  private

  def set_default_attrs
    self.uuid = RandomCode.generate_product_uuid
  end

  module Status
    On = 'on'.freeze
    Off = 'off'.freeze
  end
end
