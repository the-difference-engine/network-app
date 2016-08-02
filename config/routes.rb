Rails.application.routes.draw do

  resources :technologies
  resources :salary_ranges
  resources :industries
  resources :position_types
  resources :positions
  devise_for :admins, :skip => [:registrations], controllers: { 
    sessions: 'admins/sessions',
    # registrations: 'admins/registrations'
  }
  as :admin do
    get 'admins/edit' => 'devise/registrations#edit', :as => 'edit_admin_registration'    
    patch 'admins' => 'devise/registrations#update', :as => 'admin_registration'            
  end

  devise_for :students, :skip => [:registrations], controllers: { 
    sessions: 'students/sessions',
    # registrations: 'students/registrations'
  }
  as :student do
    get 'students/edit' => 'devise/registrations#edit', :as => 'edit_student_registration'    
    patch 'students' => 'devise/registrations#update', :as => 'student_registration'            
  end

  devise_for :employers, controllers: { 
    sessions: 'employers/sessions',
    registrations: 'employers/registrations'
  }

  root 'pages#setup_root'
  
  get '/sign_in' => 'pages#sign_in', as: :home_sign_in
  get '/students/invitations/batch' => 'students#batch', as: :student_batch_invite
  get '/employers/invitations/batch' => 'employers#batch', as: :employer_batch_invite
  get '/admins/invitations/batch' => 'admin#batch', as: :admin_batch_invite

  namespace :api do
    namespace :v1 do
      resources :admins
      resources :students
      resources :employers
    end
  end

  resources :admins
    get '/dashboard' => 'admins#admin_center', as: :admin_center
    get '/admin/admins/new' => 'admins#new', as: :new_admin_admin
    post '/admin/admins/new' => 'admins#create', as: :admin_admins
    get '/admin/students/new' => 'students#new', as: :new_admin_student
    post '/admin/students' => 'students#create', as: :admin_students
    get '/admin/employers/new' => 'employers#new', as: :new_admin_employer
    post '/admin/employers' => 'employers#create', as: :admin_employers
  
  resources :students 
  
  resources :employers
  resources :projects
  resources :positions
  resources :batch_invitations


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
