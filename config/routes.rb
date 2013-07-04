PoliticalKickstarter::Application.routes.draw do
  devise_for :users, controllers: {:omniauth_callbacks => 'authentications', :registrations => 'registrations'}
  resources :users, only: [:index, :show]
  
  resources :campaigns
  
  resources :topics, only: [:index, :show]

  # get 'tags/:tag', to: 'campaigns#index', as: :tag  ==>  uncomment to enable search by tags

  root :to => "campaigns#index"
end
