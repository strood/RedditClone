require 'rails_helper'

RSpec.describe PostsController, type: :controller do

  describe "GET #show" do
    it "renders the show page for the given post" do
      get :show, { params: {id: Post.first.id } }
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

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the post title" do

      end
    end
    context "with valid params" do
      it "redirects to the posts show page on success" do

      end
    end
  end

  describe "GET #edit" do
    it "renders the edit page" do
      get :edit, { params: { id: 1 } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH and PUT #update" do
    context "with invalid params" do
      it "redirects back to the subs edit page with invalid params" do

      end
    end
    context "with valid params" do
      it "redirects to the sub show page on success" do

      end
    end
  end

  describe "DELETE #destroy" do
    it "" do

    end
  end
end
