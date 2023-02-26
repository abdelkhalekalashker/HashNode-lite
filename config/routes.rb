Rails.application.routes.draw do
  get 'users/profile'
  devise_for :users , controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  resources :articles do 
      resources :comments 
  end



  get 'u/:id' , to: 'users#profile', as: "user"
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "home", to: "pages#home"
  # Defines the root path route ("/")
   root "pages#home"
end
