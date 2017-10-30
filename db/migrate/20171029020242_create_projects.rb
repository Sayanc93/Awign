class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :category
      t.references :company, foreign_key: true
      t.references :project_manager, foreign_key: true, null: true

      t.timestamps
    end
  end
end
