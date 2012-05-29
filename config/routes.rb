Taskmanager::Application.routes.draw do
  resources :users
  resources :stories do
    resources :comments, :only => [:create]
  end
  resource :session, :only => [:new, :create, :destroy]

  root :to => 'welcome#index'
end
