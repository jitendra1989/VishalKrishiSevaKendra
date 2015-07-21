require 'rails_helper'

RSpec.describe Admin::RolesController, type: :controller do
  let(:user) { FactoryGirl.create(:super_admin) }
  let(:role) { FactoryGirl.create(:role) }
  let(:valid_attributes) { FactoryGirl.attributes_for(:role) }
  let(:invalid_attributes) { FactoryGirl.attributes_for(:role, name: nil) }
  before do
    log_in user
  end

  describe "GET #index" do
    it "assigns all roles as @roles" do
      get :index
      expect(assigns(:roles)).to eq(Role.all)
    end
  end

  describe "GET #new" do
    it "assigns a new role as @role" do
      get :new
      expect(assigns(:role)).to be_a_new(Role)
    end
  end

  describe "GET #edit" do
    it "assigns the requested role as @role" do
      get :edit, id: role.id
      expect(assigns(:role)).to eq(role)
    end
  end

  describe "GET #create" do
    context "with valid params" do
      it "creates a new Role" do
        expect {
          post :create, role: valid_attributes
        }.to change(Role, :count).by(1)
      end

      it "assigns a newly created role as @role" do
        post :create, role: valid_attributes
          expect(assigns(:role)).to be_an(Role)
          expect(assigns(:role)).to be_persisted
      end

      it "redirects to the role list" do
          post :create, role: valid_attributes
          expect(response).to redirect_to(admin_roles_url)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved role as @role" do
        post :create, role: invalid_attributes
        expect(assigns(:role)).to be_a_new(Role)
      end

      it "re-renders the 'new' template" do
          post :create, role: invalid_attributes
          expect(response).to render_template("new")
      end
    end
  end

  describe "GET #update" do
    context "with valid params" do
      it "updates the requested role" do
          put :update, id: role.id, role: valid_attributes
          expect(assigns(:role)).to have_attributes(valid_attributes)
      end

      it "assigns the requested role as @role" do
        put :update, id: role.id, role: valid_attributes
        expect(assigns(:role)).to eq(role)
      end

      it "redirects to the role list" do
        put :update, id: role.id, role: valid_attributes
        expect(response).to redirect_to(admin_roles_url)
      end
    end

    describe "with permissions" do
      let(:permission) { FactoryGirl.create(:permission) }
      it "add the selected permissions to the role" do
        expect {
          post :update, id: role.id, role: valid_attributes.merge(permission_ids: [permission.id])
          }.to change(RolePermission, :count).by(1)
      end
    end

    context "with invalid params" do
      it "assigns the role as @role" do
        put :update, id: role.id, role: invalid_attributes
        expect(assigns(:role)).to eq(role)
      end

      it "re-renders the 'edit' template" do
        put :update, id: role.id, role: invalid_attributes
        expect(response).to render_template("edit")
      end
    end
  end

  describe "GET #destroy" do
    let!(:delete_role) { FactoryGirl.create(:role) }
    it "destroys the requested role" do
      expect {
        delete :destroy, id: delete_role.id
      }.to change(Role, :count).by(-1)
    end

    it "redirects to the roles list" do
        delete :destroy, id: delete_role.id
        expect(response).to redirect_to(admin_roles_url)
    end
  end

end
