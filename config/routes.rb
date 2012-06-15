Estore::Application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  resource :showroom do
    resources :products, :only => [ :index, :show ] do
      collection do
        post 'sort'
      end
    end
  end

  devise_scope :user do
    root :to => "devise/sessions#new"
  end
end
