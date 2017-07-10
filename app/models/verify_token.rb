class VerifyToken < ApplicationRecord
  validates_presence_of :token
  validates_presence_of :cellphone

  scope :available, -> { where('expired_at > :time', time: Time.now) }

  def self.upsert(cellphone, token)
    cond = { cellphone: cellphone }
    record = find_by(cond)
    if record
      record.update_attributes token: token, expired_at: Time.now + 10.minutes
    else
      record = create cond.merge(token: token, expired_at: Time.now + 10.minutes)
    end

    record
  end
end
