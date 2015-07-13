require 'rails_helper'

RSpec.describe Admin::CustomersController, type: :controller do
	let(:user) { FactoryGirl.create(:admin) }
	let(:customer) { FactoryGirl.create(:customer) }
	let(:valid_attributes) { FactoryGirl.attributes_for(:customer) }
	let(:invalid_attributes) { FactoryGirl.attributes_for(:customer, name: nil ) }
	before do
		log_in user
	end

	describe "GET #edit" do
		it "assigns the requested customer as @customer" do
			get :edit, id: customer.id
			expect(assigns(:customer)).to eq(customer)
		end
	end

	describe "GET #index" do
		it "assigns all customers as @customers" do
			get :index
			expect(assigns(:customers)).to eq(Customer.all)
		end
		it "renders the application layout" do
			get :index
			expect(response).to render_template('layouts/admin/application')
		end
	end

	describe "GET #new" do
		it "assigns a new customer as @customer" do
				get :new
				expect(assigns(:customer)).to be_a_new(Customer)
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Customer" do
				expect {
					post :create, customer: valid_attributes
					}.to change(Customer, :count).by(1)
			end
			it "assigns a newly created customer as @customer" do
				post :create, customer: valid_attributes
				expect(assigns(:customer)).to be_an(Customer)
				expect(assigns(:customer)).to be_persisted
			end
			it "redirects to the customer list" do
				post :create, customer: valid_attributes
				expect(response).to redirect_to(admin_customers_url)
			end
		end
		context "with invalid params" do
			it "assigns a newly created but unsaved customer as @customer" do
				post :create, customer: invalid_attributes
				expect(assigns(:customer)).to be_a_new(Customer)
			end
			it "re-renders the 'new' template" do
				post :create, customer: invalid_attributes
				expect(response).to render_template("new")
			end
		end
	end
	describe "PUT #update" do
		context "with valid params" do
			it "updates the requested customer" do
				put :update, id: customer.id, customer: valid_attributes
				expect(assigns(:customer)).to have_attributes(valid_attributes)
			end

			it "redirects to the customer list" do
				put :update, id: customer.id, customer: valid_attributes
				expect(response).to redirect_to(admin_customers_url)
			end
		end

		context "with invalid params" do
			it "assigns the customer as @customer" do
				put :update, id: customer.id, customer: invalid_attributes
				expect(assigns(:customer)).to eq(customer)
			end

			it "re-renders the 'edit' template" do
				put :update, id: customer.id, customer: invalid_attributes
				puts response.body
				expect(response).to render_template("edit")
			end
		end
	end
	describe "DELETE #destroy" do
		let!(:delete_customer) { FactoryGirl.create(:customer) }
		it "destroys the requested customer" do
			expect {
				delete :destroy, id: delete_customer.id
				}.to change(Customer, :count).by(-1)
		end

		it "redirects to the customers list" do
			delete :destroy, id: delete_customer.id
			expect(response).to redirect_to(admin_customers_url)
		end
	end
end
