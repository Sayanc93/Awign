require 'rails_helper'

RSpec.describe Api::V1::WorkforcesController, type: :controller do

  let(:company) { create(:company) }
  let(:manager) { create(:project_manager, company: company)}

  context "Workforces Controller" do
    describe "Project manager actions" do
      before(:each) do
        request.headers['X-Auth-Email'] = manager.email
        request.headers['X-Auth-Token'] = manager.authentication_token
      end

      it "fetches dependent Workforces for a project manager" do
        workforce_for_manager = create(:workforce,
                                       project_manager: manager,
                                       company: company)

        get :index

        result = JSON(response.body)
        expect(workforce_for_manager.id).to eq(result.first["id"])
        expect(workforce_for_manager.company_id).to eq(result.first["company_id"])
      end

      it "creates workforce with name paramater" do
        expect {
          post :create, params: { name: 'workforce test' }
          }.to change(Workforce, :count).by(1)
        result = JSON(response.body)
        expect(manager.workforces.last.name).to eq('workforce test')
      end

      it "returns authentication error if interns try to create workforces" do
        intern = create(:intern, company: company)
        post :create, params: { email: intern.email, name: 123 }
        result = JSON(response.body)
        expect(response.status).to eq(401)
        expect(result["message"]).to eq("Could not authenticate with the provided credentials")
      end
    end
  end
end
