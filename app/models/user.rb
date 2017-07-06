class User < ApplicationRecord
  authenticates_with_sorcery!

  validates_presence_of :email, message: '邮箱不能为空'
  validates_format_of :email, message: '邮箱不合法', with: /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/, if: proc { |user| !user.email.blank? }
  validates :email, uniqueness: true

  validates_presence_of :password, message: '密码不能为空', if: :need_validate_password
  validates_presence_of :password_confirmation, message: '密码确认不能为空', if: :need_validate_password
  validates_confirmation_of :password, message: '密码不一致', if: :need_validate_password
  validates_length_of :password, minimum: 6, message: '密码最短为 6 位', if: :need_validate_password, allow_blank: true

  has_many :addresses, -> { where(address_type: Address::AddressType::User).order('id desc') }
  belongs_to :default_address, class_name: :Address, optional: true

  has_many :orders

  private

  def need_validate_password
    new_record? || !(password.nil? && password_confirmation.nil?)
  end
end
