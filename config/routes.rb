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
  get("/questions/new", to: "questions#new", as: "new_question")

  # Create a question (submitting the new question form)
  post("/questions", to: "questions#create")

  # Render a question show page
  # Helper method would use the id as an argument
  # question_path(<id>) or question_path(instance)
  get("/questions/:id", to: "questions#show", as: "question")

  # Render a list of all questions
  get("/questions", to: "questions#index")

  # Render a form to edit an existing question
  # Helper method would use the id as an argument
  # edit_question_path(<id>) or edit_question_path(instance)
  get("/questions/:id/edit", to: "questions#edit", as: "edit_question")

  # Update a question in the database (submission of the edit form)
  patch("/questions/:id", to: "questions#update")

  # Delete a question
  delete("questions/:id", to: "questions#destroy")
end
