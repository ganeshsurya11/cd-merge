###############################################################################
#    Copyright (c) 2014, Carl Stahmer - www.carlstahmer.com                   #
#                                                                             #
#    This file is part of the Collex Edition Builder, a platform              #
#    publishing digital editions with a complete, FRBRized system of          #
#    metadata management and linked-data functionality.                       #
#                                                                             #
#    The Collex Edition Builder is free software: you can redistribute it     #
#    and/or modify it under the terms of the GNU General Public License       #
#    as published by the Free Software Foundation, either version 3 of        #
#    the License, or (at your option) any later version.                      #
#                                                                             #
#    The Collex Edition Builder is distributed in the hope that it will       #
#    be useful, but WITHOUT ANY WARRANTY; without even the implied warranty   #
#    of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the         #
#    GNU General Public License for more details.                             #
#                                                                             #
#    You should have received a copy of the GNU General Public License        #
#    along with The Collex Edition Builder distribution.  If not,             #
#    see <http://www.gnu.org/licenses/>.                                      #
#                                                                             #
#    Development of this software was made possible through funding from      #
#    the National Endowment for the Humanities as well as the Institute       #
#    for Digital Humanities, Media, and Culture at Texas A&M University.      #
###############################################################################
Donne::Application.routes.draw do
  resources :nav_categories

  get '/digital_editions/:parent/new', to: 'digital_editions#new'
  get '/digital_editions/:parent/getitem', to: 'digital_editions#getitem'
  get '/digital_editions/:id/delobj', to: 'digital_editions#deledition'
  resources :digital_editions

  get '/trans/:id/fedit', to: 'trans#fedit'
  get '/trans/:parent/newtrans', to: 'trans#newtrans'
  get '/trans/:parent/getexpressions', to: 'trans#getexpressions'
  post '/transcriptions/update_order', to: 'transcriptions#update_order'
  post '/transcriptions/update_file', to: 'transcriptions#update'
  get '/transcriptions/:parent/newtrans', to: 'transcriptions#newtrans'
  get '/transcriptions/:id/dump', to: 'transcriptions#dump'
  resources :transcriptions

  get '/pages/:parent/view', to: 'pages#view'
  get '/pages/page', to: 'pages#page'
  get '/pages/:p/page/:parent', to: 'pages#page'
  get '/pages/:parent/new', to: 'pages#new'
  get '/pages/:id/edit', to: 'pages#edit'
  get '/pages/:parent/new', to: 'pages#new'
  get '/pages/:id/delobj', to: 'pages#delpage'
  resources :pages


  resources :surrogates


  resources :item_events

  get '/items/:parent/new', to: 'items#new'
  get '/items/:id/delobj', to: 'items#delitem'
  resources :items


  resources :manifestation_events


  resources :manifestations_events

  get '/manifestations/:parent/new', to: 'manifestations#new'
  get '/manifestations/:id/delobj', to: 'manifestations#delman'
  resources :manifestations
  
  
  get '/admin/:sub', to: 'admin#index'
  get '/admin', to: 'admin#index'
  post '/admin', to: 'admin#index'


  resources :system_event_types


  resources :local_markup_mappings


  resources :user_roles


  resources :confs

  get '/holding_institutions/:id/ref/:referer', to: 'holding_institutions#show'
  get '/holding_institutions/:referer/index', to: 'holding_institutions#index'
  get '/holding_institutions/:id/edit/:referer', to: 'holding_institutions#edit'
  get '/holding_institutions/:referer/new', to: 'holding_institutions#new'
  resources :holding_institutions
  
  get '/his/new', to: 'his#new'


  resources :manifestation_types


  resources :locations


  resources :agents


  resources :roles


  resources :event_types


  resources :expression_types
  
  get '/expressions/:parent/new', to: 'expressions#new'
  get '/expressions/:id/delobj', to: 'expressions#delexp'
  resources :expressions


  resources :entities

  get '/works/:id/delobj', to: 'works#delwork'
  resources :works


  resources :concordance_entries


  resources :concordance_stop_words
  
  match 'dotei/:id' => 'lines#dotei'

  resources :lines
  
  resource :secrets
  
  resource :users
  
  match 'login' => 'sessions#new'
  
  resource :sessions
  
  match 'sessions/destroy' => 'sessions#destroy'

  get '/splash', to: 'splash#index'

  get '/editions/:id', to: 'editions#show'
  get '/ed/:id', to: 'editions#show'

  get '/edition/:id/concordance', to: 'concordance#showedition'

  get 'edition/:id/concordance/:it', to: 'concordance#showeditem'

  get '/viewport/:id', to: 'view_port#show'
  get '/viewport/:id/:token', to: 'view_port#show'
  get '/viewport/:parent/page/:page', to: 'view_port#getpage'

  get '/doconcord/:id', to: 'concordance_entries#build_edition_concordance'

  get '/edition/:id/toc/:t', to: 'toc#showtoc'
  get '/edition/:id/toc', to: 'toc#showtoc'

  get '/utility/:id/tansrebuild', to: 'utility#update_lines'
  get '/utility/MakeMedThumb', to: 'utility#make_medium_thumb'


  root :to => 'splash#index'

  get '/zoom/:id', to: 'zoom#show'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
