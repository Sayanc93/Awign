class Api::V1::TasksController < Api::V1::BaseController
  def show
    project = @user.projects.find(permitted_params[:project_id])
    task = project.tasks.find(permitted_params[:id])
    render json: task
  end

  def assign_intern
    project = @user.projects.find(permitted_params[:project_id])
    task = project.tasks.find(permitted_params[:id])
    task.update_attributes(intern_id: permitted_params[:intern_id])
    task.in_progress!
    render json: task
  end

  def create
    project = @user.projects.find(permitted_params[:project_id])
    intern = project.interns.find(permitted_params[:intern_id])
    task = project.tasks.build(name: permitted_params[:name],
                               intern: intern,
                               description: permitted_params[:description])
    if task.save
      task.in_progress! if task.intern.present?
      render json: project.tasks
    else
      render_errors("Task could not be created, check parameters sent.")
    end
  end

  def change_status
    project = @user.projects.find_by(id: permitted_params[:project_id])
    task = project.tasks.find(permitted_params[:id])
    requested_status = permitted_params[:status]

    if requested_status == "in_progress"
      task.in_progress!
    elsif requested_status == "done"
      task.done!
    elsif requested_status == "backlog"
      task.backlog!
    elsif requested_status == "unassigned"
      task.update_attributes(intern_id: nil)
      task.unassigned!
    end

    render json: task
  end

  private

  def permitted_params
    params.permit(:id, :project_id, :intern_id, :status, :description, :name)
  end
end
