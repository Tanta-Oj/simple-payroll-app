class Member < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  belongs_to :user
  default_scope -> { order(id: :asc) }
  validates :name, presence: true, length: {maximum: 30}
  validates :scheduled_hours_h, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24}
  validates :scheduled_hours_m, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  validates :workday, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :paid_holiday, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :leave_deduction, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :normal_hours_h, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :normal_hours_m, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  validates :overtime_hours_h, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :overtime_hours_m, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  validates :holiday_hours_h, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :holiday_hours_m, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  validates :midnight_hours_h, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :midnight_hours_m, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  validates :late_early_h, allow_blank: true, numericality: { greater_than_or_equal_to: 0}
  validates :late_early_m, allow_blank: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}
  # validates :scheduled_hours_h, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24}, on: :edit
  # validates :scheduled_hours_h, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 24}, on: :update
  # validates :scheduled_hours_m, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}, on: :edit
  # validates :scheduled_hours_m, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 59}, on: :update
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable, :timeoutable, :trackable
end
