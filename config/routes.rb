Rails.application.routes.draw do
  # devise_for :members, controllers: {
  #   sessions:      "members/sessions",
  #   passwords:     "members/passwords",
  #   registrations: "members/registrations",
  #   confirmations: "members/confirmations",
  #   unlocks:       "members/unlocks"
  # }

  devise_for :members, :pathn_prefix => "my", controllers: {
      sessions:      "members/sessions",
      passwords:     "members/passwords",
      registrations: "members/registrations",
      confirmations: "members/confirmations",
      unlocks:       "members/unlocks"
    }
  resources :members

  devise_scope :member do
    get "/members/sign_out", to: "members/sessions#destroy", as: :member_logout
  end

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    registrations: "users/registrations",
    confirmations: "users/confirmations",
    unlocks:       "users/unlocks"
  }


  root 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
