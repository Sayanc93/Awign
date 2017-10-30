class ProjectManager < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  belongs_to :company
  has_many :workforces
  has_many :projects
  has_many :tasks

  validates_presence_of :email
  validates_uniqueness_of :email
end
