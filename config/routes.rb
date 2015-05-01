Rails.application.routes.draw do

  get 'submissions/show'

  resources :ratings
  resources :comments
  resources :artworks do
    resources :ratings, :comments
  end

  resources :documents do
    resources :ratings, :comments
    member do 
      post 'toggle_approved'
    end
    collection do 
      get 'download'
      get 'test'
    end
  end

  devise_for :users, :skip => :registrations
  devise_for :submitters, :editors, :skip => :sessions, :controllers => { registrations: 'registrations'}
  devise_for :admins, :skip => :sessions
  # devise_for :users, :controllers => { sessions: 'sessions' }


  get 'home/index'
  get 'home/help'

  get 'submissions/show'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  resources :users do
    member do
      put 'toggle_admin_role'
      put 'toggle_approved_status'
    end
    collection do 
      get 'users'
      get 'admin_tools'
      get 'new_submitter'
      post 'create_submitter'
    end
  end

  resources :settings, only: [:index, :edit, :update] do
    collection do
      get 'export_to_csv'
    end
  end


  # devise_for :users, :controllers => { registrations: 'registrations' }


  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
