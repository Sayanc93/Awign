require 'rails_helper'

RSpec.describe Api::V1::ProjectsController, type: :controller do

  let(:company) { create(:company) }
  let(:manager) { create(:project_manager, company: company)}

  context "Projects Controller" do
    describe "Project actions" do
      before(:each) do
        request.headers['X-Auth-Email'] = manager.email
        request.headers['X-Auth-Token'] = manager.authentication_token
      end

      it "fetches projects of a company with unassigned manager" do
        project_of_company = create(:project,
                                    company: company)

        get :index

        result = JSON(response.body)
        expect(company.projects.first.id).to eq(result.first["id"])
        expect(company.id).to eq(result.first["company_id"])
      end

      it "assigns manager to existing project" do
        project = create(:project)
        expect(project.project_manager_id).to eq(nil)

        post :assign_manager, params: { id: project.id, manager_id: manager.id }

        result = JSON(response.body)
        expect(project.reload.project_manager_id).to eq(result["project_manager_id"].to_i)
      end

      it "creates project with name and category paramater" do
        expect {
          post :create, params: { name: 'project test', category: 'student' }
          }.to change(Project, :count).by(1)
        result = JSON(response.body)
        expect(manager.projects.last.name).to eq('project test')
        expect(manager.projects.last.category).to eq('student')
      end

      it "returns authentication error if interns try to create projects" do
        intern = create(:intern, company: company)
        post :create, params: { email: intern.email, name: 'project test', category: 'student' }
        result = JSON(response.body)
        expect(response.status).to eq(401)
        expect(result["message"]).to eq("Could not authenticate with the provided credentials")
      end
    end
  end
end
