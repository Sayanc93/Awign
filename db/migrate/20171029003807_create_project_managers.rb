class CreateProjectManagers < ActiveRecord::Migration[5.1]
  def change
    create_table :project_managers do |t|
      t.references :company,          foreign_key: true
      t.string :name,                 default: ''

      t.timestamps
    end
  end
end
