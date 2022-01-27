Rails.application.routes.draw do
  # For details see http://guides.rubyonrails.org/routing.html
  root to: 'tag#index'
  get '/hello', to: 'welcome#greet'
  resources :tag
  resources :message
end
