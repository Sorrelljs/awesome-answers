class QuestionsController < ApplicationController
  # Pass a method name as a symbol to "before_action" to run it before all of the actions listed
  # This will find the question using the "id" from the params and save it to @question,
  # so all of the actions listed has the @question defined.
  before_action :find_question, only: [:show, :edit, :update, :destroy]

  def new
    # Create a new instance of a question which will be
    # available as an argument to "form_with"
    @question = Question.new
  end

  def create
    # The "params" hash is available in controllers and it 
    # includes the query string, url params, and the body of a 
    # form submission.

    # Render the params as JSON to view a readable format of 
    # the data. This is like doing response.send(req.body) in Express:
    # render json: params

    @question = Question.new question_params

    if @question.save
      # Use "redirect_to" to tell the browser to make a new request.
      # The method takes in a route helper as an argument. For the 
      # show route, we pass an id to the url helper for the question
      # to render. But we can also just pass the instance of the question 
      # and rails knows to grab the id from the instance:
      # redirect_to question_path(@question)
      redirect_to question_path(@question.id)
    else
      # If we use "redirect_to", the data in the body will be gone from
      # the params. Therefore we will render the new page so the user
      # can see their inputs in the form to modify it if it failed 
      # validation.
      render :new
    end
  end

  def show
  end

  def index
    @questions = Question.all.order(created_at: :desc)
  end

  def edit
  end

  def update
    if @question.update question_params
      redirect_to question_path(@question)
    else
      render :edit 
    end
  end

  def destroy
    @question.destroy
    redirect_to questions_path
  end

  private

  def question_params
    # Use "require" on the params object to retrieve the nested 
    # hash of a key corresponding to the form data. We can also 
    # use "permit" to specify all input names that are allowable
    # because sometimes we don't need all the values from a form. 
    params.require(:question).permit(:title, :body)
  end

  def find_question
    @question = Question.find params[:id]
  end
end
