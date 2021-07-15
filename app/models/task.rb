class Task < ApplicationRecord
  scope :search_by_title, ->(query) { where('title LIKE ?', "%#{query}%") }
  scope :search_by_status, ->(status) { where(status: status) }

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  enum status: [ '未着手', '着手中', '完了' ]
  enum priority: [ '高', '中', '低' ]

  belongs_to :user
end
