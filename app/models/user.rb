class User < ApplicationRecord
  has_many :questions, dependent: :nullify
  has_many :answers, dependent: :nullify

  has_secure_password
  # Provides user authentication features on the model that it is
  # called in. It requires a column named "password_digest" to store
  # hashed passwords, and it requires the bcrypt gem.
  # - It adds attribute accessors for "password" and "password_confirmation".
  # - If "password_confirmation" exists then it makes sure it matches 
  #   with "password". "password_confirmation" is optional.
  # - It will add a presence validation for the "password" field.
  # - It will save passwords assigned to "password" using bcrypt to hash
  #   and store it in the "password_digest" column.
  # - It will add a "authenticate" to verify a user's password. bcrypt will
  #   verify the password by hashing it and comparing it to the "password_digest".
  #   If the password was correct it returns the user, otherwise it returns false.
  validates(
    :email, 
    presence: true, 
    uniqueness: true,
    format: /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i,
  )

  def full_name
    "#{first_name} #{last_name}".strip
  end
end
