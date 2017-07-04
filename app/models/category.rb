class Category < ApplicationRecord
  has_many :products, dependent: :destroy

  validates :title, presence: { message: '名称不能为空' }
  validates :title, uniqueness: { message: '名称不能重复' }

  before_validation :correct_ancestry

  has_ancestry orphan_strategy: :destroy

  private

  def correct_ancestry
    self.ancestry = nil if ancestry.blank?
  end
end
