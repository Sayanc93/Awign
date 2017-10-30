class Api::V1::ProjectsController < Api::V1::BaseController
  def index
    render json: @user.company.projects
  end

  def assign_manager
    project = Project.find(permitted_params[:id])
    project.update_attributes(project_manager_id: permitted_params[:manager_id])
    render json: project
  end

  def create
    project = @user.projects.build(name: permitted_params[:name],
                                   company: @user.company,
                                   category: permitted_params[:category])
    if project.save
      render json: @user.projects
    else
      render_errors("Project could not be created, check parameters sent.")
    end
  end

  private

  def permitted_params
    params.permit(:name, :manager_id, :id, :category)
  end
end
