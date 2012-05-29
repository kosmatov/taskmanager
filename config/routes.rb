Taskmanager::Application.routes.draw do
  scope :module => :web do
    root :to => 'welcome#index'

    resources :stories do
      resources :comments, :only => [:create]
    end

    resources :users
    resource :session, :only => [:new, :create, :destroy]
  end
end
