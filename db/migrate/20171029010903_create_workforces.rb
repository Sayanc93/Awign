class CreateWorkforces < ActiveRecord::Migration[5.1]
  def change
    create_table :workforces do |t|
      t.references :project_manager,  foreign_key: true
      t.references :company,  foreign_key: true
      t.string :name, default: ''

      t.timestamps
    end
  end
end
