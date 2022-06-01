class User < ApplicationRecord
  rolify

  has_many :posts

  # Include default devise modules. Others available are:
  # :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :trackable, :confirmable
  # enum role: [:user, :moderator, :admin]
  # after_initialize :set_default_role, :if => :new_record?
  # def set_default_role
  #   self.role ||= :user
  # end

  after_create :assign_default_role

  validate :must_have_a_role, on: :update

  private

  def assign_default_role
    self.add_role(:newuser) if self.roles.blank?
  end

  def must_have_a_role
    unless roles.any?
      errors.add(:roles, "Must have at least one role !")
    end
  end
end
