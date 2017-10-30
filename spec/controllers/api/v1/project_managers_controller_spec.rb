require 'rails_helper'

RSpec.describe Api::V1::ProjectManagersController, type: :controller do

  let(:company) { create(:company) }
  let(:manager) { create(:project_manager, company: company)}
  let(:workforce) { create(:workforce, company: company) }
  let(:project) { create(:project, project_manager: manager)}
  let(:intern) { create(:intern, company: company, workforce: workforce, project: project) }

  context "Project Managers Controller" do
    describe "Managerial actions" do
      before(:each) do
        request.headers['X-Auth-Email'] = manager.email
        request.headers['X-Auth-Token'] = manager.authentication_token
      end

      it "creates Intern account and adds to workforce" do
        post :add_intern, params: { name: "New intern",
                                    intern_email: "1234@323.com",
                                    workforce_id: workforce.id,
                                    authentication_token: "auth_token_master" }
        result = JSON(response.body)

        expect(Intern.last.id).to eq(result["id"])
        expect(Intern.last.workforce.id).to eq(result["workforce_id"])
        expect(Intern.last.email).to eq(result["email"])
        expect(Intern.last.authentication_token).to eq(result["authentication_token"])
      end

      it "removes Intern from assigned task" do
        task = create(:task,
                      project: project,
                      intern: intern,
                      status: "in_progress")

        post :remove_intern_from_task, params: { project_id: project.id,
                                                 intern_id: intern.id,
                                                 task_id: task.id }
        result = JSON(response.body)

        expect(task.reload.intern_id).to eq(nil)
        expect(task.reload.status).to eq("unassigned")
      end
    end
  end
end
