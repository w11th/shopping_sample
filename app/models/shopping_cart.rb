class ShoppingCart < ApplicationRecord
  validates :user_uuid, presence: true
  validates :product_id, presence: true
  validates :amount, presence: true

  belongs_to :product

  scope :find_by_user_uuid, ->(uuid) { where(user_uuid: uuid) }

  def self.create_or_update!(options = {})
    cond = {
      user_uuid: options[:user_uuid],
      product_id: options[:product_id]
    }

    record = where(cond).first
    if record
      record.update_attributes!(options.merge(amount: record.amount + options[:amount]))
    else
      record = create!(options)
    end
    record
  end
end
