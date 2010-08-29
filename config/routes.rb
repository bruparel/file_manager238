ActionController::Routing::Routes.draw do |map|

  map.root :controller => 'welcome'

  map.login           'login',           :controller => 'user_sessions',          :action => 'new'
  map.logout          'logout',          :controller => 'user_sessions',          :action => 'destroy'
  map.reset           'reset' ,          :controller => 'user_sessions',          :action => 'reset'
  map.change          'change',          :controller => 'users',                  :action => 'edit_password'
  map.update_password 'update_password', :controller => 'users',                  :action => 'update_password'
  map.help            'help',            :controller => 'users',                  :action => 'toggle_help'
  map.admin           'admin',           :controller => 'admin',                  :action => 'instruct'
  map.basic_info      'basic_info',      :controller => 'clients',                :action => 'edit'
  map.notes           'notes',           :controller => 'client_comments',        :action => 'index'

  map.resources :user_sessions
  map.resources :users
  map.resources :clients
  map.resources :client_perms, :collection => { :assign => :put }
  map.resources :client_comments
  map.resources :folders, :collection => { :populate => :put }
  map.resources :folder_perms, :collection => { :assign => :put }
  map.resources :documents
  map.resources :document_statuses, :client_statuses, :base_folders

  map.connect ':controller/:action/:id'
end
