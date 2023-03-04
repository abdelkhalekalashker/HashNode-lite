Rails.application.routes.draw do
  authenticated :user, ->(user){user.admin?} do
    get 'admin', to:"admin#index"
    get 'admin/show_article/:id',to: "admin#show_article" , as: "admin_article"
    get 'admin/comments'
    get 'admin/users'
    get 'admin/articles'
  end
  get 'search' , to: "search#index"
  # get 'users/profile'
  devise_for :users , controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'u/:id' , to: 'users#profile', as: "user"
  resources :after_signup

  resources :articles do
    resources :comments
  end

  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "home", to: "pages#home"
  # Defines the root path route ("/")
   root "pages#home"
end
