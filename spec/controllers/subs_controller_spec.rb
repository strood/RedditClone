require 'rails_helper'

RSpec.describe SubsController, type: :controller do
  describe "GET #index" do
    it "renders the index page filled with all the subs" do
      get :index, {}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders the show page for the given sub" do
      get :show, { params: {id: Sub.first.id } }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:show)
    end
  end

  describe "GET #new" do
    it "renders the new sub page" do
      get :new, {}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with invalid params" do
      it "validates the presence of the sub title" do

      end
      it "validates the presence of the sub description" do

      end
    end
    context "with valid params" do
      it "redirects to subs show page on success" do

      end
    end
  end

  describe "GET #edit" do
    it "renders the edit page" do
      get :edit, :params => { id: Sub.first.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH and PUT #update" do
    context "with invalid params" do
      it "redirects back to the subs edit page with invalid params" do
        patch :update, params: { id: Sub.first.id,  title: "" }
        expect(response).to redirect_to("subs/edit/*")
      end
    end
    context "with valid params" do
      it "redirects to the sub show page on success" do

      end
    end
  end

  describe "DELETE #destroy" do
    it "redirects to the subs index page on success" do
      delete :destroy, params: { id: Sub.first.id }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end
end
