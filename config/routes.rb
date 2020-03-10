Rails.application.routes.draw do
  devise_for :users
  root "homes#top"
      resources :books do
  	resources :post_comments,only:[:create,:destroy,:edit,:update]
  	 resource :favorites,only:[:create,:destroy]
  end
  resources :users,only:[:new,:create,:index,:edit,:update,:show]
  get "home/about" => "homes#about"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  post 'follow/:id' => 'relationships#follow', as: 'follow' # フォローする
  post 'unfollow/:id' => 'relationships#unfollow', as: 'unfollow' # フォロー外す
end