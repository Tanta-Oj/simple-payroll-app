class Payroll < ApplicationRecord
    cattr_accessor :savecount

    belongs_to :user
    validates :user_id, presence: true
    belongs_to :member
    validates :member_id, presence: true
    default_scope -> { order(created_at: :desc) }
    validates :availability, inclusion: { in: [true, false] }

    validates :basic_salary, numericality: { greater_than_or_equal_to: 0}
    validates :overtime_allowance, numericality: { greater_than_or_equal_to: 0}
    validates :holiday_allowance, numericality: { greater_than_or_equal_to: 0}
    validates :midnight_allowance, numericality: { greater_than_or_equal_to: 0}
    validates :commutation_allowance_tax, numericality: { greater_than_or_equal_to: 0}
    validates :commutation_allowance_nontax, numericality: { greater_than_or_equal_to: 0}
    validates :allowance_1, numericality: { greater_than_or_equal_to: 0}
    validates :allowance_2, numericality: { greater_than_or_equal_to: 0}
    validates :allowance_3, numericality: { greater_than_or_equal_to: 0}
    validates :allowance_4, numericality: { greater_than_or_equal_to: 0}
    validates :allowance_5, numericality: { greater_than_or_equal_to: 0}
    validates :paid_holiday_allowance, numericality: { greater_than_or_equal_to: 0}
    validates :leave_deduction_price, numericality: { greater_than_or_equal_to: 0}
    validates :late_early_price, numericality: { greater_than_or_equal_to: 0}

    def self.choice(userid,choice)
        if choice && userid
            Payroll.where(user_id: userid, pay_day: choice).order(member_id: "ASC")
        end
    end

    def self.choice_m(memberid,choice)
        if choice && memberid
            Payroll.where(member_id: memberid, pay_day: choice).order(created_at: "DESC")
        end
    end
end
