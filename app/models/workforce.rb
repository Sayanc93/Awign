class Workforce < ApplicationRecord
  belongs_to :company
  belongs_to :project_manager

  validates_presence_of :project_manager
end
