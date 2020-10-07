Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  #do I want the following (per odin project)
  # root to: "welcome#index"
  get '/', to: 'welcome#index'
  get '/shelters', to: 'shelters#index'
end
