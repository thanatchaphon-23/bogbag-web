class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  # Validation for username
  validates :username, presence: true, uniqueness: true, length: { maximum: 50 }
  validates :email, presence: true, uniqueness: true
    # Overriding Devise to find user by username instead of email
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if (username = conditions.delete(:username))
      where(conditions).where(["username = :value", { value: username }]).first
    else
      where(conditions).first
    end
  end
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
end
