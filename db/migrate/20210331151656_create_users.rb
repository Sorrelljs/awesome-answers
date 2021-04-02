class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name

      # Add an index to columns that we query often. It will improve 
      # the performance of the query. We'll add an index to email
      # because we'll be using email to lookup users often.
      t.string :email, index: { unique: true }
      t.string :password_digest

      t.timestamps
    end
    # if you needed to add an index on the exsisting table: 
    # add_index :users, :email, unique:true 
  end
end
