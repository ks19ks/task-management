class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true

  enum status: [ '未着手', '着手中', '完了' ]
end
