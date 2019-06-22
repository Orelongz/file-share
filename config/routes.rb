Rails.application.routes.draw do
  root 'documents#index'
  resources :documents, only: %i[new create index destroy]
end
