class Api::V1::ProjectManagersController < Api::V1::BaseController
  def add_intern
    new_intern = Intern.new(email: permitted_params[:intern_email],
                            name: permitted_params[:name],
                            company_id: @user.company.id,
                            workforce_id: permitted_params[:workforce_id],
                            authentication_token: permitted_params[:authentication_token],
                            password: "test1234",
                            password_confirmation: "test1234")

    if new_intern.save
      render json: new_intern
    else
      render_errors("Could not create new intern, check paramters passed.")
    end
  end

  def remove_intern_from_task
    project = @user.projects.find(permitted_params[:project_id])
    intern = project.interns.find(permitted_params[:intern_id])
    task = intern.tasks.find(permitted_params[:task_id])
    if task.unassigned!
      task.update_attributes(intern_id: nil)
      render json: task
    else
      render_errors("Could not update task status.")
    end
  end

  private

  def permitted_params
    params.permit(:intern_email,
                  :name,
                  :workforce_id,
                  :authentication_token,
                  :project_id,
                  :intern_id,
                  :task_id)
  end
end
