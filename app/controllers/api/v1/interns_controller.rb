class Api::V1::InternsController < Api::V1::BaseController
  def tasks
    render json: @user.tasks
  end

  def project
    render json: @user.project
  end
end
