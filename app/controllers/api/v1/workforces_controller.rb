class Api::V1::WorkforcesController < Api::V1::BaseController
  def index
    render json: @user.workforces
  end

  def create
    workforce = @user.workforces.build(name: permitted_params[:name], company: @user.company)
    if workforce.save
      render json: @user.workforces
    else
      render_errors("Workforce could not be created, check parameters sent.")
    end
  end

  private

  def permitted_params
    params.permit(:name)
  end
end
