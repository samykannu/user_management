Rails.application.routes.draw do
  resources :user_dynamic_columns
  resources :users
  resources :roles do
  	collection do
  		get 'hide_roles'
  		post 'post_hide_roles'
  	end
    member do
      get 'update_status'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "users#index"
end
