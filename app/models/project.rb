class Project < ApplicationRecord
  belongs_to :company
  belongs_to :project_manager, optional: true

  has_many :tasks
  has_many :interns
end
