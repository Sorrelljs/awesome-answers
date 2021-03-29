Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post('/contact', {to:"contact#create"})
  get("/contact/new", { to: "contact#new"}) 

# This defines a route definition that says when recieve a GET request to "/", handle it in 
# the WelcomeController with the "index" (instance method) action inside the controller. The "as"
# option defines a helper url/path method. By default rails will automatically generate the helper 
# for you, but we can rename it using "As" option. All similar HTTP verbs have an associated
# method named after the verb. 
  get("/", { to: "welcome#index", as:"root"})
end
