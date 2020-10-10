class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  has_many :members, dependent: :destroy
  accepts_nested_attributes_for :members
  validates :name, presence: true, length: {maximum: 30}
  validates :pay_year, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :pay_month, allow_blank: true, numericality: { greater_than_or_equal_to: 1, less_than_or_equal_to: 12}
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
end
