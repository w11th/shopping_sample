class Order < ApplicationRecord
  validates_presence_of :user_id, :product_id, :address_id, :total_money, :amount
  validates_uniqueness_of :order_no

  belongs_to :user
  belongs_to :product
  belongs_to :address
  belongs_to :payment, optional: true

  before_create :gen_order_no

  module OrderStatus
    Initial = 'initial'.freeze
    Paid = 'paid'.freeze
  end

  def paid?
    status == OrderStatus::Paid
  end

  def self.create_order_from_shopping_carts!(user, address, *shopping_carts)
    shopping_carts.flatten!

    address_attrs = address.attributes.except!("id", "created_at", "updated_at")

    orders = []
    transaction do
      order_address = user.addresses.create!(
        address_attrs.merge(
          "address_type" => Address::AddressType::Order
        )
      )
      orders = shopping_carts.map do |shopping_cart|
        user.orders.create!(
          product: shopping_cart.product,
          address: order_address,
          amount: shopping_cart.amount,
          total_money: shopping_cart.amount * shopping_cart.product.price
        )
      end

      shopping_carts.map(&:destroy!)
    end
    orders
  end

  private

  def gen_order_no
    self.order_no = RandomCode.generate_order_uuid
  end
end
