# frozen_string_literal: true

# creates table kp_jwt_tokens to track/verify tokens
class CreateUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :users do |t|
      t.string :email, unique: true, null: false
      t.string :password_digest, null: false

      t.timestamps null: false
    end

    add_index :users, [:email]
  end
end
