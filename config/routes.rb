Rails.application.routes.draw do
  get 'customers/main'
  get 'customers/test'
  post 'customers/search'
  get 'customers/searchResults'
  get 'customers/noSearchResults'
  get 'customers/googleMapsTest'

  root 'customers#main'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
