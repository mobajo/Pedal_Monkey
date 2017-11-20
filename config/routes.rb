Rails.application.routes.draw do
  get 'accommodations/show'

  get 'accommodations/new'

  get 'accommodations/create'

  get 'accommodations/update'

  get 'accommodations/edit'

  get 'accommodations/destroy'

  get 'stages/index'

  get 'stages/show'

  get 'stages/new'

  get 'stages/create'

  get 'stages/update'

  get 'stages/edit'

  get 'stages/destroy'

  get 'trips/index'

  get 'trips/show'

  get 'trips/new'

  get 'trips/create'

  get 'trips/edit'

  get 'trips/update'

  get 'trips/destroy'

  get 'users/show'

  get 'users/new'

  get 'users/create'

  get 'users/update'

  get 'users/edit'

  get 'users/destroy'

  get 'trip_members/index'

  get 'trip_members/show'

  get 'trip_members/new'

  get 'trip_members/create'

  get 'trip_members/destroy'

  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
