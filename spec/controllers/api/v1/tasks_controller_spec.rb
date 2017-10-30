require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do

  let(:company) { create(:company) }
  let(:manager) { create(:project_manager, company: company)}
  let(:workforce) { create(:workforce, company: company) }
  let(:project) { create(:project, project_manager: manager)}
  let(:intern) { create(:intern, company: company, workforce: workforce, project: project) }

  context "Tasks Controller" do
    describe "Tasks actions" do
      before(:each) do
        request.headers['X-Auth-Email'] = manager.email
        request.headers['X-Auth-Token'] = manager.authentication_token
      end

      it "fetches task details of a task" do
        task = create(:task,
                      project: project,
                      intern: intern,
                      status: "in_progress")

        get :show, params: { id: task.id, project_id: project.id }

        result = JSON(response.body)
        expect(task.id).to eq(result["id"])
        expect(task.status).to eq(result["status"])
      end

      it "assigns intern to existing task" do
        task = create(:task,
                      project: project)
        expect(task.intern_id).to eq(nil)
        expect(task.status).to eq("unassigned")

        post :assign_intern, params: { id: task.id, project_id: project.id, intern_id: intern.id }

        result = JSON(response.body)
        expect(task.reload.intern_id).to eq(result["intern_id"])
        expect(task.reload.status).to eq("in_progress")
      end

      it "creates tasks with name and category paramater associated with a project" do
        expect {
            post :create, params: { project_id: project.id,
                                    intern_id: intern.id,
                                    name: 'Test task',
                                    description: 'Test description' }
          }.to change(Task, :count).by(1)

        result = JSON(response.body)
        expect(project.tasks.last.id).to eq(result.last["id"])
        expect(project.tasks.last.name).to eq(result.last['name'])
        expect(project.tasks.last.description).to eq(result.last['description'])
        expect(project.tasks.last.intern_id).to eq(result.last["intern_id"])
      end

      it "changes status of task according to params" do
        task = create(:task,
                      project: project,
                      intern: intern,
                      status: "in_progress")

        post :change_status, params: { id: task.id, project_id: project.id, status: "done" }

        result = JSON(response.body)
        expect(task.reload.status).to eq(result["status"])
      end
    end
  end
end
