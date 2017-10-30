class CreateTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tasks do |t|
      t.references :intern, foreign_key: true, null: true
      t.references :project, foreign_key: true
      t.string :name
      t.string :description
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
