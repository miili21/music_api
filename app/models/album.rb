class Album < ApplicationRecord
  has_many :releases, dependent: :destroy

  validates :title, presence: true
end
