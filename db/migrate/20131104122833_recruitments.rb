class Recruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.integer :user_id
      t.integer :recruit_id

      t.timestamps
    end
  end
end
