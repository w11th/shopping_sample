class Order < ApplicationRecord
  validates_presence_of :user_id, :product_id, :address_id, :total_money, :amount, :order_no
  validates_uniqueness_of :order_no

  belongs_to :user
  belongs_to :product
  belongs_to :address

  before_create :gen_order_no

  private

  def gen_order_no
    self.order_no = RandomCode.generate_order_uuid
  end
end
