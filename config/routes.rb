Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  post("/contact", { to: "contact#create" })
  get("/contact/new", { to: "contact#new" })

  # This defines a route definition that says when a GET request to "/" is made, handle it in the 
  # WelcomeController with the "index" (instance method) action inside the controller. The "as"
  # option names a helper url/path method. By default, Rails will automatically generate the helper
  # for you, but we can rename it using the "as" option. All similar HTTP verbs have an associated
  # method named after the verb.
  get("/", { to: "welcome#index", as: "root" })

  # Renders a form to create a new question
  # get("/questions/new", to: "questions#new", as: "new_question")

  # Create a question (submitting the new question form)
  # post("/questions", to: "questions#create")

  # Render a question show page
  # Helper method would use the id or instance as an argument
  # question_path(<id>) or question_path(instance)
  # get("/questions/:id", to: "questions#show", as: "question")

  # Render a list of all questions
  # get("/questions", to: "questions#index")

  # Render a form to edit an existing question
  # Helper method would use the id or instance as an argument
  # edit_question_path(<id>) or edit_question_path(instance)
  # get("/questions/:id/edit", to: "questions#edit", as: "edit_question")

  # Update a question in the database (submission of the edit form)
  # patch("/questions/:id", to: "questions#update")

  # Delete a question
  # delete("questions/:id", to: "questions#destroy")

  ##########

  # The "resources" method will generate all the CRUD routes above

  # following RESTful conventions for a resource. It will assume that
  # there is a controller named after the first argument pluralized and
  # PascalCased e.g. (:questions => QuestionsController)
  resources :questions do 
    # The routes written inside of a block passed to the "Resources"
    # will be prefixed by a path corresponding to the passed in symbol.
    # In this case all routes will be prefixed with "questions/question_id"

    #"only" creates the routes that we need and "expect" will create
    # all the routes with the expect of routes in the array.
    # Passing the shallow: True will remove the prefix if it doesn't read it.

    # This stays the same because we need the :question_id
    # when creating an answer
    # POST/questions/:question_id/answers

    # The prefix is removed for :destroy because we only need the id of 
    # the answer we are destroying 
    # DELETE /questions/:question_id/answers/:id
    #becomes
    # DELETE answers/:id
    resources :answers, only: [:create, :destroy], shallow: true
  end

    resources :users, only: [:new, :create]

    # Resource is singular if we preform CRUD action on a single 
    # thing and not a collection of resources. There's no index, no routes
    # that have :id wildcard. Even though the resource
    # is singular, the controller is still plural
    resource :session, only: [:new, :create, :destroy]

end
