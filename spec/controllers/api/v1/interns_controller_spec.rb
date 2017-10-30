require 'rails_helper'

RSpec.describe Api::V1::InternsController, type: :controller do

  let(:company) { create(:company) }
  let(:manager) { create(:project_manager, company: company)}
  let(:workforce) { create(:workforce, company: company) }
  let(:project) { create(:project, project_manager: manager)}
  let(:intern) { create(:intern, company: company, workforce: workforce, project: project) }
  let(:task) { create(:task, project: project, intern: intern, status: "in_progress") }

  context "Interns Controller" do
    describe "Intern actions" do
      before(:each) do
        request.headers['X-Auth-Email'] = intern.email
        request.headers['X-Auth-Token'] = intern.authentication_token
      end

      it "fetches tasks for an Intern" do
        get :tasks, params: { id: task.id }
        result = JSON(response.body)
        expect(task.id).to eq(result.last["id"])
      end

      it "fetches projects for an Intern" do
        get :project, params: { id: task.id }

        result = JSON(response.body)
        expect(project.id).to eq(result["id"])
      end
    end
  end
end
