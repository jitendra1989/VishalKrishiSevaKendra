require 'rails_helper'

RSpec.describe Admin::QuotationsController, type: :controller do
	let(:user) { FactoryGirl.create(:sales_executive) }
	let(:quotation) { FactoryGirl.create(:quotation) }
	let(:customer) { FactoryGirl.create(:customer) }
	let(:valid_attributes) { FactoryGirl.attributes_for(:quotation) }
	let(:invalid_attributes) { FactoryGirl.attributes_for(:quotation, discount_amount: nil) }
	before do
		log_in user
	end

	describe "GET #index" do
		it "assigns all quotations as @quotations" do
			get :index
			expect(assigns(:quotations)).to eq(Quotation.all)
		end
	end

	describe "GET #show" do
		it "assigns the requested quotation as @quotation" do
			get :show, id: quotation.id
			expect(assigns(:quotation)).to eq(quotation)
		end
	end

	describe "GET #new" do
		it "assigns a new quotation as @quotation to the customer" do
			get :new, customer_id: customer.id
			expect(assigns(:customer)).to eq(customer)
			expect(assigns(:quotation)).to be_a_new(Quotation)
			expect(assigns(:quotation).customer).to eq(customer)
		end
	end

	describe "POST #create" do
		let(:product) { FactoryGirl.create(:product) }
		context "with valid params" do
			it "creates a new Quotation" do
				expect {
					post :create, customer_id: customer.id, quotation: valid_attributes
					}.to change(Quotation, :count).by(1)
			end

			it "assigns a newly created quotation as @quotation" do
				post :create, customer_id: customer.id, quotation: valid_attributes
				expect(assigns(:quotation)).to be_an(Quotation)
				expect(assigns(:quotation)).to be_persisted
			end

			it "redirects to the quotation list" do
				post :create, customer_id: customer.id, quotation: valid_attributes
				expect(response).to redirect_to(admin_quotations_url)
			end

			describe "with product" do
				it "creates a new QuotationProduct" do
					expect {
						post :create, customer_id: customer.id, quotation: valid_attributes.merge(products_attributes: [ product_id: product.id, quantity:  Faker::Number.between(1, 10) ])
						}.to change(QuotationProduct, :count).by(1)
				end
			end
		end

		context "with invalid params" do
			it "assigns a newly created but unsaved quotation as @quotation" do
				post :create, customer_id: customer.id, quotation: invalid_attributes
				expect(assigns(:quotation)).to be_a_new(Quotation)
			end
			it "re-renders the 'new' template" do
				post :create, customer_id: customer.id, quotation: invalid_attributes
				expect(response).to render_template("new")
			end
		end
	end

	describe "GET #products" do
		let(:product) { FactoryGirl.create(:product) }
		it "returns products matching name provided via search" do
			get :products, q: product.name
			expect(assigns(:products)).to include(product)
		end
	end
end
