class CreateTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
    end

    create_table :teams do |t|
      t.string :name
    end

    create_table :memberships do |t|
      t.integer :user_id
      t.integer :team_id
      t.string  :role
      t.datetime :created_at
    end
  end
end
