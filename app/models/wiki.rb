class Wiki < ActiveRecord::Base
  belongs_to :user
  has_many :collaborators
  has_many :users, through: :collaborators
  after_create :add_collaborator

  def public?
    !private
  end

  def collaborator(user_id)
    collaborators.find_by(user_id: user_id)
  end

  private

  def add_collaborator
    collaborators.create(user_id: user.id)
  end
end
