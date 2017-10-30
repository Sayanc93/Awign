class Task < ApplicationRecord
  belongs_to :intern, optional: true
  belongs_to :project

  enum status: [:unassigned, :backlog, :in_progress, :done]
end
