Rails.application.routes.draw do
  resources :stories, defaults: { format: :json }
  resources :articles, defaults: { format: :json }
end
