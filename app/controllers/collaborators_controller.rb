class CollaboratorsController < ApplicationController
  before_action :set_wiki, only: [:index, :create, :destroy]
  def index
    @users = User.all
  end

  def create
    collaborator = @wiki.collaborators.new(user_id: params[:user_id])
    if collaborator.save
      flash[:notice] = "Collaborator added"
    else
      flash[:alert] = "Failed to add collaborator"
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  def destroy
    collaborator = Collaborator.find(params[:id])
    if collaborator.destroy
      flash[:notice] = "Collaborator removed"
    else
      flash[:alert] = "Failed to remove collaborator"
    end
    redirect_to wiki_collaborators_path(@wiki)
  end

  private
  def set_wiki
    @wiki = Wiki.find(params[:wiki_id])
  end
end
