Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'
  resources :articles, except: [:destroy]
  delete 'articles/:id/delete' => 'articles#destroy', as: 'articles_delete'
  get 'articles/:id/delete' => 'articles#destroy'
  get 'signup' => 'users#new'
  resources :users, except: [:new]
end
