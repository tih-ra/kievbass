ActionController::Routing::Routes.draw do |map|
  # The priority is based upon order of creation: first created -> highest priority.

  map.home "", :controller => "articles", :format => "html"

  map.resources :users
  map.resources :sessions
  map.resources :pages
  map.resources :invitations
  map.resources :podcasts
  map.resources :articles
  map.resources :talks
  map.resources :comments
  
  map.activate "/activate/:activation_code", :controller => "users", :action => "new"

  map.signup "/signup", :controller => "users", :action => "new"
  map.login "/login", :controller => "sessions", :action => "new"
  map.logout "/logout", :controller => "sessions", :action => "destroy"
  
  map.with_options :path_prefix => "admin", :name_prefix => "admin_" do |admin|
    admin.resources :podcasts, :controller => "admin/podcasts"
    admin.resources :pages, :controller => "admin/pages", :new => {:preview => :any}
    admin.resources :articles, :controller => "admin/articles", :edit => {:update => :any}
    admin.resources :invitations, :controller => "admin/invitations", :member=>{:activate=>:get}
    admin.resources :users, :controller => "admin/users"
  end

  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate'
  
  # Install the default route as the lowest priority.
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/page/:page'
  map.connect ':controller/:action/page/:page'
  map.connect ':controller/:action/:id'
  
end
