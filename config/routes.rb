Rails.application.routes.draw do
  get 'dosage/index'
  get 'dosage/new'
  get 'dosage/edit'
  get 'dosage/create'
  get 'dosage/update'
  get 'dosage/destroy'
  get 'dosage/show'
  get 'ingredients/index'
  get 'ingredients/new'
  get 'ingredients/edit'
  get 'ingredients/create'
  get 'ingredients/update'
  get 'ingredients/destroy'
  get 'ingredients/show'
  get 'cocktails/index'
  get 'cocktails/new'
  get 'cocktails/edit'
  get 'cocktails/create'
  get 'cocktails/update'
  get 'cocktails/destroy'
  get 'cocktails/show'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
