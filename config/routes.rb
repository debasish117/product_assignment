Rails.application.routes.draw do
  devise_for :users
  root to: "suppliers#index"
  resources :suppliers
  resources :products
  resources :admin_dashboards, only: [ :create ] do
    collection do
      delete :wipe_data
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
