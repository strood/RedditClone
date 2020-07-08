require 'rails_helper'

# NOTE: In order for tests to  pass you must first disable:
#  before_action :require_current_user! - in posts_controller.rb
# AND
# before_action :require_user_owns_post!, only: [:edit]

RSpec.describe PostsController, type: :controller do

  describe "GET #show" do
    it "renders the show page for the given post - IF FAILING CHECK NOTES AT TOP OF SPEC FILE" do
      p = Post.create!(title: Faker::Name.name, author: User.first)
      get :show, { params: {id: p.id } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the new post page" do
      get :new, {}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  # TODO:
  # Becuase i use @current_user to set the author in the controller, I cant
  # seem to get the author to set on creation, making me unable to test the function
  #  need to find how to set the author and i can actuallty test
  # describe "POST #create" do
  #   context "with invalid params" do
  #     it "validates the presence of the post title" do
  #       post :create, :params => { :post => { :title => "",
  #                                             :author => User.first } }
  #     end
  #     it "validates the presence of the post author" do
  #       u = User.create!(username: Faker::Name.name, password: "123456")
  #       post :create, :params => { :post => { :title => "Solid Title",
  #                                             :author => "" } }
  #     end
  #   end
  #   context "with valid params" do
  #     it "redirects to post show page on success" do
  #       u = User.create!(username: Faker::Name.name, password: "123456")
  #       @current_user = u
  #       post :create, :params => { :post => { :title => "Solid Title" } }
  #     end
  #   end
  # end

  describe "GET #edit" do
    it "renders the edit page" do
      get :edit, { params: { id: 1 } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH and PUT #update" do
      it "redirects to the sub show page on success" do
        p = Post.create!(title: Faker::Name.name, author: User.first)
        put :update, :params => { id: p.id, :post => { :title => "new-title" } }
        expect(response).to have_http_status(302)
        expect(response).to redirect_to("/posts/#{p.id}/edit")
      end
  end

  describe "DELETE #destroy" do
    it "redirects to the sub it belonged to on success" do
      p = Post.create!(title: Faker::Name.name, author: User.first)
      delete :destroy, params: { id: p.id }
      expect(response).to have_http_status(302)
    end
  end
end
