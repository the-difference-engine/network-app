Rails.application.routes.draw do

  devise_for :admins, controllers: { 
    sessions: 'admins/sessions',
    registrations: 'admins/registrations'
  }
  devise_for :students, controllers: { 
    sessions: 'students/sessions',
    registrations: 'students/registrations'
  }
  devise_for :employers, controllers: { 
    sessions: 'employers/sessions',
    registrations: 'employers/registrations'
  }

  root 'students#index'
  
  get '/sign_in' => 'pages#sign_in'

  # namespace :admin do
  #   resources :employers
  #   resources :students
  # end


  resources :admins
    get '/admin_center' => 'admins#admin_center', as: :admin_center
    get '/admin/admins/new' => 'admins#new', as: :new_admin_admin
    post '/admin/admins/new' => 'admins#create', as: :admin_admins
    get '/admin/students/new' => 'students#new', as: :new_admin_student
    post '/admin/students' => 'students#create', as: :admin_students
    get '/admin/employers/new' => 'employers#new', as: :new_admin_employer
    post '/admin/employers' => 'employers#create', as: :admin_employers
  resources :students
  resources :employers


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
