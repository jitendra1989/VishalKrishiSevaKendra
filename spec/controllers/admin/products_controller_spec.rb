require 'rails_helper'

RSpec.describe Admin::ProductsController, type: :controller do
	let(:user) { FactoryGirl.create(:super_admin) }
	let(:product) { FactoryGirl.create(:product) }
	let(:product_type) { FactoryGirl.create(:product_type) }
	let(:valid_attributes) { FactoryGirl.attributes_for(:product).merge(product_type_id: product_type.id) }
	let(:invalid_attributes) { FactoryGirl.attributes_for(:product, code: nil) }
	let(:related_product) { FactoryGirl.create(:product) }

	let(:category) { FactoryGirl.create(:category) }
	let(:sub_category) { FactoryGirl.create(:sub_category) }

	describe "without login" do
		it "redirects to the login page" do
			get :index
			expect(response).to redirect_to(login_admin_users_url)
		end
	end

	describe " logged in user" do
		before do
			log_in user
		end
		describe "GET #index" do
			it "assigns all products as @products" do
				get :index
				expect(assigns(:products)).to eq(Product.all.page(1).per(20))
			end
		end

		describe "GET #edit" do
			it "assigns the requested product as @product" do
				get :edit, id: product.id
				expect(assigns(:product)).to eq(product)
			end
		end

		describe "GET #new" do
			it "assigns a new product as @product" do
				get :new
				expect(assigns(:product)).to be_a_new(Product)
			end
		end

		describe "GET #show" do
			it "returns http success" do
				get :show, id: product.friendly_id
				expect(assigns(:product)).to eq(product)
			end
		end

		describe "POST #create" do
			context "with valid params" do
				it "creates a new Product" do
					expect {
						post :create, product: valid_attributes
						}.to change(Product, :count).by(1)
				end

				it "assigns a newly created product as @product" do
					post :create, product: valid_attributes
					expect(assigns(:product)).to be_an(Product)
					expect(assigns(:product)).to be_persisted
				end

				it "redirects to the product list" do
					post :create, product: valid_attributes
					expect(response).to redirect_to(admin_products_url)
				end
			end

			describe "with categories" do
				it "add the selected categories to the product" do
					expect {
						post :create, product: valid_attributes.merge(category_ids: [category.id, sub_category.id])
						}.to change(ProductCategory, :count).by(2)
				end
			end

			describe "with cross sell" do
				it "add the selected cross sell products to the product" do
					expect {
						post :create, product: valid_attributes.merge(cross_sale_product_ids: [related_product.id])
						}.to change(CrossSell, :count).by(1)
				end
			end
			describe "with image" do
				let(:cv_file) { fixture_file_upload('test.pdf', 'application/pdf') }
				let(:png_file) { fixture_file_upload('test.png', 'image/png') }
				it "creates a new Product image" do
					expect {
						post :create, product: valid_attributes.merge(images_attributes: [ name: png_file ])
						}.to change(ProductImage, :count).by(1)
				end
				it "uploads the image" do
					post :create, product: valid_attributes.merge(images_attributes: [ name: png_file ])
					expect(response).to redirect_to(admin_products_url)
				end
				it "renders the show page when a non image is uploaded" do
					post :create, product: valid_attributes.merge(images_attributes: [ name: cv_file ])
					expect(response).to render_template(:new)
				end
			end

			context "with invalid params" do
				it "assigns a newly created but unsaved product as @product" do
					post :create, product: invalid_attributes
					expect(assigns(:product)).to be_a_new(Product)
				end

				it "re-renders the 'new' template" do
					post :create, product: invalid_attributes
					expect(response).to render_template("new")
				end
			end
		end

		describe "PUT #update" do
			context "with valid params" do
				it "updates the requested product" do
					put :update, id: product.id, product: valid_attributes
					expect(assigns(:product)).to have_attributes(valid_attributes)
				end

				it "assigns the requested product as @product" do
					put :update, id: product.id, product: valid_attributes
					expect(assigns(:product)).to eq(product)
				end

				it "redirects to the product list" do
					put :update, id: product.id, product: valid_attributes
					expect(response).to redirect_to(admin_products_url)
				end
			end

			context "with invalid params" do
				it "assigns the product as @product" do
					put :update, id: product.id, product: invalid_attributes
					expect(assigns(:product)).to eq(product)
				end

				it "re-renders the 'edit' template" do
					put :update, id: product.id, product: invalid_attributes
					expect(response).to render_template("edit")
				end
			end

			describe "with image" do
				let(:png_file) { fixture_file_upload('test.png', 'image/png') }
				let!(:image) { FactoryGirl.create(:product_image, product: product) }
				it "deletes an existing Product image" do
					expect {
						post :update, id: product.id, product: valid_attributes.merge(images_attributes: [ id: image.id, _destroy: true ])
						}.to change(ProductImage, :count).by(-1)
				end
			end

			describe "with categories" do
				it "add the selected categories to the product" do
					expect {
						post :update, id: product.id, product: valid_attributes.merge(category_ids: [category.id, sub_category.id])
						}.to change(ProductCategory, :count).by(2)
				end
			end

			describe "with cross sell" do
				it "add the selected cross sell products to the product" do
					expect {
						post :update, id: product.id, product: valid_attributes.merge(cross_sale_product_ids: [related_product.id])
						}.to change(CrossSell, :count).by(1)
				end
			end
		end

		describe "DELETE #destroy" do
			let!(:delete_product) { FactoryGirl.create(:product) }
			it "destroys the requested product" do
				expect {
					delete :destroy, id: delete_product.id
					}.to change(Product, :count).by(-1)
			end

			it "redirects to the products list" do
				delete :destroy, id: delete_product.id
				expect(response).to redirect_to(admin_products_url)
			end
		end

		describe "GET #search" do
			it "returns productss matching name provided via search" do
				get :search, q: product.name
				expect(assigns(:products)).to include(product)
				expect(response).to render_template(:index)
			end
		end
	end
end
