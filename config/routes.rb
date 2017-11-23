Rails.application.routes.draw do

  resources :trips do
    resources :stages
  end

  resources :trips do
    resources :stages do
      resources :pitstops
    end
  end

  get "dashboard", to: "trips#dashboard"
  get "designguide", to: "pages#designguide"

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
