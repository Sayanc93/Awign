class Company < ApplicationRecord
  has_many :workforces
  has_many :projects
  has_many :project_managers
end
