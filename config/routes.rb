Rails.application.routes.draw do
  resources :stories, defaults: { format: :json }
end
