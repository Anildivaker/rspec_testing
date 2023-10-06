class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :surname
      t.string :name
      t.string :email
      t.integer :number
      t.string :username
      t.string :password

      t.timestamps
    end
  end
end
