Rails.application.routes.draw do
  root 'stories#index', defaults: { format: :json }

  resources :stories, defaults: { format: :json }
  resources :articles, defaults: { format: :json }

  mount ActionCable.server => '/cable'
end
