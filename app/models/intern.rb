class Intern < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  has_many :tasks

  belongs_to :company
  belongs_to :workforce
  belongs_to :project, optional: true

  validates_presence_of :email
  validates_uniqueness_of :email
end
