=begin
  ToronHot Dog
  Router

  This file directs incoming HTTP requests to the right functions in the CustomersController
  class to call. It uses URLs to match.

  VERSION 1.0
  Start Date: February 27, 2018
  End Date: April 11, 2018

  File Name: routes.rb

  Original Source Code © 2018 Gregory Desrosiers. All rights reserved.
=end

Rails.application.routes.draw do

  # This makes the root of the website point to the main pane, which loads the search interface.
  root 'customers#main'

  # This route for a GET request will make the controller render the search interface.
  get 'customers/main'

  # This route for a POST request will have the controller process the search with the given
  # search constraints and preferences, which will then return a JSON string.
  post 'customers/search'


  # This route for a GET request will have the controller render and return the
  # template where search results do exist, and so will be displayed in a Google Maps widget.
  get 'customers/searchResults'

  # This route for a GET request will have the controller render and return the
  # template to show the user that the search query has not found any hot dog stands.
  get 'customers/noSearchResults'


  # These two routes were for development purposes to test out the model loads and
  # the search result loads with Google Maps.
  #get 'customers/test'
  #get 'customers/googleMapsTest'
end
