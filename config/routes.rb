Rails.application.routes.draw do	
  root 'welcomeuser#welcome'
  #get "/sign_in" => "/resource/sign_in", :as => "user_root"
  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users do
  	resources :customreviewrules
    resources :projects
    get 'search/index'     
    resources :results 
  end
    resources :projects do      
    resources :notes   
    end
    resources :reviews 
    resources :role_masters 
    resources :page_masters
    resources :role_pages
    resources :user_roles
    resources :prj_reviews
    resources :results 
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
      get '/role_master' => 'role_masters#index', :as => "rolemaster"
      get '/reviews' => 'reviews#index', :as => "reviews_index"
      get '/projects' => 'projects#index', :as => "projects_index"
      get '/page_master'=> 'page_masters#index', :as => "page_masters_index"
      get '/role_pages'=> 'role_pages#index', :as => "role_pages_index"
      get '/user_roles'=> 'user_roles#index', :as => "user_roles_index"
      get '/prj_reviews'=> 'prj_reviews#index', :as => "prjreviews_index"
      get '/customreviewrules'=> 'customreviewrules#index', :as => "customreviewrules"
      get '/results'=> 'results#index', :as => "resultofproject"
      post '/results'=> 'results#create', :as => "resultofproject_create"
      get '/projects/:project_id/notes/:id' => 'notes#show', :as => 'note'      
      get '/search' => 'search#index',:as => 'search_index'
     
     get "/projreview/:id/:tof" => "results#projreview", :as => "projreview"
end	
