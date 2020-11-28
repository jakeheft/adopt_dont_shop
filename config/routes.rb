Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #do I want the following (per odin project)
  root to: "welcome#index"

  resources :shelters

  resources :pets

  get '/pets/:pet_id/applications', to: 'pet_applications#index'

  namespace :shelters do
    get '/:id/pets', to: 'pets#index'
    get '/:shelter_id/pets/new', to: 'pets#new'
    post '/:shelter_id/pets', to: 'pets#create'
  end

  get '/shelters/:shelter_id/reviews/new', to: 'reviews#new'
  post '/shelters/:shelter_id', to: 'reviews#create'
  get '/shelters/:shelter_id/reviews/:review_id/edit', to: 'reviews#edit'
  patch '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#update'
  delete '/shelters/:shelter_id/reviews/:review_id', to: 'reviews#destroy'

  resources :users, only: %i[new create show]

  resources :applications, only: %i[new create show update]

  post '/pet_applications/:pet_id/:application_id', to: 'pet_applications#create'
  patch '/pet_applications/:pet_id/:application_id/:response', to: 'pet_applications#update'

  get '/admin/applications/:application_id', to: 'admin_applications#show'

end
