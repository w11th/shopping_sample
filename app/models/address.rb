class Address < ApplicationRecord
  validates_presence_of :user_id, :address_type, :contact_name, :cellphone, :address

  belongs_to :user

  module AddressType
    User = 'user'.freeze
    Order = 'order'.freeze
  end

  attr_accessor :set_as_default

  after_save :set_as_default_address
  before_destroy :remove_self_as_default_address

  private

  def set_as_default_address
    if set_as_default.to_i == 1
      user.default_address = self
      user.save!
    else
      remove_self_as_default_address
    end
  end

  def remove_self_as_default_address
    if user.default_address == self
      user.default_address = nil
      user.save!
    end
  end
end
