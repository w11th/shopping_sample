class User < ApplicationRecord
  authenticates_with_sorcery!

  attr_accessor :password, :password_confirmation, :token

  CELLPHONE_RE = /\A(\+86|86)?1\d{10}\z/
  EMAIL_RE = /\w+([-+.']\w|)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/

  validates_presence_of :password, message: '密码不能为空', if: :need_validate_password
  validates_presence_of :password_confirmation, message: '密码确认不能为空', if: :need_validate_password
  validates_confirmation_of :password, message: '密码不一致', if: :need_validate_password
  validates_length_of :password, minimum: 6, message: '密码最短为 6 位', if: :need_validate_password, allow_blank: true

  validate :validate_email_or_cellphone, on: :create

  has_many :addresses, -> { where(address_type: Address::AddressType::User).order('id desc') }
  belongs_to :default_address, class_name: :Address, optional: true

  has_many :orders
  has_many :payments

  private

  def validate_email_or_cellphone
    if [emaill, cellphone].all? { |attr| attr.nil? }
      errors.add :base, '邮箱和手机号其中之一不能为空'
      return false
    else
      if cellphone.nil?
        if email.blank?
          errors.add :email, '邮箱不能为空'
          return false
        else
          unless email =~ EMAIL_RE
            errors.add :email, '邮箱格式不正确'
            return false
          end
        end
      else
        unless cellphone =~ CELLPHONE_RE
          errors.add :cellphone, '手机号格式不正确'
          return false
        end

        unless VerifyToken.available.find_by(cellphone: cellphone, token: token)
          errors.add :cellphone, '手机验证码不正确或者已经过期'
          return false
        end
      end
    end
    return true
  end

  def need_validate_password
    new_record? || !(password.nil? && password_confirmation.nil?)
  end
end
