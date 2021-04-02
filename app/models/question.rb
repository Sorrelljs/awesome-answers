class Question < ApplicationRecord
    # Active Record is known as an ORM, an Object Relational Mapper
    # We use objects to represent tables and data from our database.
    # This class "Question" represents the "questions" table.
    # Instances of the Question class represent a row of data in 
    # the "questions" table.
  
    # We generated this file when we ran the following command. 
    # Make sure that model is singular.
    # rails g model question title body:text
  
    # For each column/attribute, the attr_accessors are already defined.
    # We can access each attribute for each instance e.g. "body", "title"
    # When reading the attributes on the instance, we can just read it as is:
    # title => "My title"
    # When writing the attributes, we have prefix with self (instance)
    # self.title = "My new title"


    # Adding the "dependent :destroy" option tells rails to delete the associated 
    # answers before deleting the question
    # "has_many" was not automatically added to this model when we generate
    # answers so make sure you add it when setting up associations.
    has_many :answers, dependent: :destroy
    belongs_to :user
  

    # === VALIDATIONS ===
    # To create validations, use the "validates" method.
    # The arguments are:
    # 1. The column name to validate as a symbol
    # 2. Named arguments corresponding to the validation rules
    # To read more on validations: https://guides.rubyonrails.org/active_record_validations.html
    
    validates(:title, presence: true, uniqueness: true)
  
    # To read an array of error messages after failing validation:
    # record.errors.full_messages
    validates(
      :body, 
      # Custom error messages begin with the column name in the string already
      # "Body must include a question"
      presence: { message: "must include a question" },
      length: { minimum: 10 },
    )
  
    validates(:view_count, numericality: { greater_than_or_equal_to: 0 })
  
    # === CUSTOM VALIDATIONS ===
    # Use the "validate" (singluar) method for custom validations. It takes the
    # custom validation method name to call as a symbol for the argument. 
    # "no_monkey" and "no_title_in_body" are private methods in this model.
    validate(:no_monkey)
    validate(:no_title_in_body)
  
    # === SCOPES ===
    # Create a scope with a class method. We can create a scope with
    # the "scope" method. The arguments are:
    # 1. The class method's name as a symbol
    # 2. A lambda
    scope(:recent_ten, ->{ order(created_at: :desc).limit(10) })
    # To call the method, use Question.recent_ten
    # The above is equivalent to:
    # def self.recent_ten
    #   order(created_at: :desc).limit(10)
    # end
  
    scope(:search, ->(word){ where('title ILIKE ? OR body ILIKE ?', "%#{word}%", "%#{word}%") })
  
    # === CALLBACKS ===
    # There exists many callbacks that run at different 
    # stages of a record's lifecycle. List of callbacks found here:
    # https://guides.rubyonrails.org/active_record_callbacks.html#available-callbacks
    
    # Using a block
    before_save do 
      # self is the record/instance
      # Immediately before saving to the database, captialize the title
      self.title = title.capitalize 
    end
  
    # Using a method
    before_validation(:set_default_view_count)
  
    private
  
    def no_monkey
      # &. is a safe navigation operator. It's used like the "." operator to 
      # call methods on an object. If the method does not exist for 
      # the object, "nil" will be returned instead of raising an error.
      # Similar to body && body.downcase && body.downcase.include?("monkey")
      if body&.downcase&.include?("monkey")
        # To make a record invalid, add a validation error using the 
        # "add" method on the error object of the instance.
        # Its arguments are:
        # 1. Name of the invalid column as a symbol
        # 2. Error message as a string
        errors.add(:body, "must not include monkeys")
      end
    end
  
    def no_title_in_body
      if body&.downcase&.include?(title.downcase)
        errors.add(:body, "must not include the title")
      end
    end
  
    def set_default_view_count
      self.view_count ||= 0
      # self.view_count = self.view_count || 0
    end
  end