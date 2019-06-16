Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  root to: "suppliers#index"
  resources :suppliers do
    member do
      get :toggle_products
    end
  end
  resources :products
  resources :admin_dashboards, only: [ :create ] do
    collection do
      delete :wipe_data
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
