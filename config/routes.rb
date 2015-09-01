Rails.application.routes.draw do
  get '/products/feedback' => 'product/feedback#index'
  
  namespace :voluntary, path: 'api', module: 'voluntary/api', defaults: {format: 'json'} do
    namespace :v1 do
      resources :communities, only: [:index, :create, :show, :update, :destroy]
      resources :community_categories, only: [:index, :create, :show, :update, :destroy]
      resources :feedbacks, only: [:index, :create, :show, :update, :destroy]
      resources :replies, only: [:index, :create, :show, :update, :destroy]
    end
  end
end