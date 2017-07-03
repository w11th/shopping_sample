class Product < ApplicationRecord
  belongs_to :category

  validates_uniquness_of :uuid

  before_create :set_default_attrs

  private

  def set_default_attrs
    self.uuid = RandomeCode.generate_product_uuid
  end
end
