class Form::PayrollCollection < Form::Base
    # include Devise::Controllers::Helpers
    # @user = User.includes(:members).find(current_user.id)
    # FORM_COUNT = 5
    cattr_accessor :savecount # controllerで設定した変数(member数)を取得
    FORM_COUNT = Payroll.savecount.to_i
    attr_accessor :payrolls
  
    def initialize(attributes = {})
        super attributes
    #   self.payrolls = DEFAULT_ITEM_COUNT.times.map { Form::Payroll.new } unless payrolls.present?
        self.payrolls = FORM_COUNT.times.map { Payroll.new() } unless self.payrolls.present?
    end
  
    def payrolls_attributes=(attributes)
        # self.payrolls = attributes.map { |_, payroll_attributes| Form::Payroll.new(payroll_attributes) }
        self.payrolls = attributes.map { |_, payroll_attributes| Payroll.new(payroll_attributes) }
        # Form::Payroll.new(payroll_attributes).tap { |v| v.availability = false }
    #   end
    end
  
    # def valid?
    #     valid_payrolls = target_payrolls.map(&:valid?).all?
    #     super && valid_payrolls
    # end
  
    def save
        # return false unless valid?
        # Payroll.transaction { target_payrolls.each(&:save!) }
        # true
        is_success = true
        Payroll.transaction do
            self.payrolls.map do |payroll|
                if payroll.availability
                    is_success = false unless payroll.save
                end
            end
            # self.payrolls.map(&:save!)
            raise ActiveRecord::RecordInvalid unless is_success
        end
            return true
        rescue => e
            return false
    end
  
    # def target_payrolls
    #     self.payrolls.select { |v| value_to_boolean(v.register) }
    # end
  end