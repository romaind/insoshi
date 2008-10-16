ActionController::Routing::Routes.draw do |map|
  map.resources :beta_coupons

  map.resources :softwares

  map.resources :skills

  map.resources :languages


  map.resources :preferences
  map.resources :searches
  map.resources :activities
  map.resources :connections
  map.resources :password_reminders
  map.resources :photos
  map.resource :session
  # map.resources :messages, :collection => { :sent => :get, :trash => :get },
  #                          :member => { :reply => :get, :undestroy => :put }


  map.resources :people, :member => { :verify_email => :get,
                                      :common_contacts => :get }
  map.connect 'people/verify/:id', :controller => 'people',
                                    :action => 'verify_email'
  map.resources :people, :collection => {:coupon_validator => :get} do |person|
     person.resources :messages, :collection => { :sent => :get, :trash => :get },
                              :member => { :reply => :get, :undestroy => :put }
     person.resources :photos
     person.resources :connections
     person.resources :comments
     person.resources :projects, :collection => {:choose => :get} do |project|
       project.resources :comments
       project.resources :creations do |creation|
         creation.resources :assets
       end
     end
  end
  map.namespace :admin do |admin|
    admin.resources :people, :preferences, :beta_coupons
    admin.resources :forums do |forums|
      forums.resources :topics do |topic|
        topic.resources :posts
      end
    end    
  end
  map.resources :blogs do |blog|
    blog.resources :posts do |post|
        post.resources :comments
    end
  end

  map.resources :forums do |forums|
    forums.resources :topics do |topic|
      topic.resources :posts
    end
  end
  
  # map.resources :projects do |project|
  #   project.resources :comments
  #   project.resources :creations do |creation|
  #     creation.resources :assets
  #   end
  # end
  map.feedback  '/feedback', :controller => 'home', :action => 'feedback'
  map.projects '/projects', :controller => 'projects', :action => 'index'
  
  map.profile 'people/:id/:tab',  :controller => 'people',
                                  :action => 'show'
                                  
  map.newproject  'people/:person_id/projects/new/:tab', :controller => 'projects', :action => 'new'
  map.editproject  'people/:person_id/projects/:id/edit/:tab', :controller => 'projects', :action => 'edit'
  
  map.simple_captcha '/simple_captcha/:action', :controller => 'simple_captcha'
  map.signup '/signup', :controller => 'people', :action => 'new'
  map.login '/login', :controller => 'sessions', :action => 'new'
  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
  
  map.abuse '/home/abuse/:item/:id', :controller => 'home', :action => 'abuse'
  map.send_abuse '/home/send_abuse', :controller => 'home', :action => 'send_abuse'
  
  map.home '/', :controller => 'home'
  map.about '/about', :controller => 'home', :action => 'about'
  map.admin_home '/admin/home', :controller => 'home'

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  map.root :controller => "home"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end
