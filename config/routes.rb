Rails.application.routes.draw do
  #delete "/doses/:id", to: 'doses#destroy'
  resources :cocktails do
    resources :doses, only: [ :index, :new, :create, :destroy]
  end

  get '/learn', to: 'cocktails#learn'

  root to: 'cocktails#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
