class User < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

  has_secure_password

  before_destroy :cannot_destroy_last_admin
  before_update :cannot_update_last_admin

  has_many :tasks, dependent: :destroy

  private

  def cannot_destroy_last_admin
    throw(:abort) if User.where(admin: true).count == 1 && self.admin?
  end

  def cannot_update_last_admin
    if User.where(admin: true).count == 1 && User.find_by(admin: true).id == self.id && self.admin == false
      errors.add(:base, '管理者権限を外すことができません')
      throw(:abort)
    end
  end
end
