class CreateInterns < ActiveRecord::Migration[5.1]
  def change
    create_table :interns do |t|
      t.references :company, foreign_key: true
      t.references :workforce, foreign_key: true
      t.references :project, foreign_key: true, null: true
      t.string :name, default: ''
      t.string :college, default: ''
      t.boolean :assigned, default: false

      t.timestamps
    end
  end
end
