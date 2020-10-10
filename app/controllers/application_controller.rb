class ApplicationController < ActionController::Base
    # protect_from_forgery with: :exception
    protect_from_forgery prepend: true, with: :exception
    before_action :configure_permitted_parameters, if: :devise_controller?

    protected
        def configure_permitted_parameters
            devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
            devise_parameter_sanitizer.permit(:sign_up, keys: [:scheduled_hours_h])
            devise_parameter_sanitizer.permit(:account_update, keys: [:name])
            devise_parameter_sanitizer.permit(:account_update, keys: [:closing_date])
            devise_parameter_sanitizer.permit(:account_update, keys: [:payday])
            devise_parameter_sanitizer.permit(:account_update, keys: [:basic_daily])
            devise_parameter_sanitizer.permit(:account_update, keys: [:allowance_1])
            devise_parameter_sanitizer.permit(:account_update, keys: [:allowance_2])
            devise_parameter_sanitizer.permit(:account_update, keys: [:allowance_3])
            devise_parameter_sanitizer.permit(:account_update, keys: [:allowance_4])
            devise_parameter_sanitizer.permit(:account_update, keys: [:allowance_5])
        end
end
