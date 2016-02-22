Rails.application.routes.draw do

	root 'employees#index'

	get 'query' => 'query#index'

  get 'settings' => 'settings#index'
  patch 'settings' => 'settings#update'

	delete 'clear_employees' => 'employees_manage#clear'

	get 'employees_manage' => 'employees_manage#index'
	post 'employees_manage' => 'employees_manage#create'
  get 'employees_export' => 'employees_manage#export'

  get 'records' => 'annual_leave_change_records#index'

  get 'records_manage' => 'annual_leave_change_records_manage#index'
  post 'records_manage' => 'annual_leave_change_records_manage#import'
  get 'records_export' => 'annual_leave_change_records_manage#export'

	get 'login' => 'sessions#new'
	post 'login' => 'sessions#create'
	delete 'logout' => 'sessions#destroy'

  resources :employees

	resources :annual_leave_change_records

  #   resources :products
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
