require 'rails_helper'

# NOTE: In order for tests to  pass you must first disable:
#  before_action :require_current_user! - in subs_controller.rb
# AND
# before_action :require_user_owns_sub!, only: [:edit]

RSpec.describe SubsController, type: :controller do
  describe "GET #index" do
    it "renders the index page filled with all the subs  - IF FAILING CHECK NOTES AT TOP OF SPEC FILE" do
      get :index, {}
      expect(response).to have_http_status(200)
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    it "renders the show page for the given sub" do
      s = Sub.create!(title: Faker::Name.name, description: Faker::Lorem.sentence(word_count: 5), moderator: User.last )
      get :show, :params => { :id => s.id }
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

  # TODO:
  # Becuase i use @current_user to set the moderator in the controller, I cant
  # seem to get the moderator to set on creation, making me unable to test the function
  #  need to find how to set the moderator and i can actuallty test
  # describe "POST #create" do
  #   context "with invalid params" do
  #     it "validates the presence of the sub title" do
  #       post :create, :params => { :sub => { :title => "",
  #                                       :description => Faker::Lorem.sentence(word_count: 5)} }
  #     end
  #     it "validates the presence of the sub description" do
  #       post :create, :params => { :sub => { :title => "Solid Title",
  #                                       :description => ""} }
  #     end
  #   end
  #   context "with valid params" do
  #     it "redirects to subs show page on success" do
  #       post :create, :params => { :sub => { :title => "SOlid Title",
  #                                       :description => Faker::Lorem.sentence(word_count: 5)} }
  #     end
  #   end
  # end

  describe "GET #edit" do
    it "renders the edit page" do
      s = Sub.create!(title: Faker::Name.name, description: Faker::Lorem.sentence(word_count: 5), moderator: User.last )
      get :edit, :params => { id: 2 }
      expect(response).to have_http_status(200)
      expect(response).to render_template(:edit)
    end
  end

  describe "PATCH and PUT #update" do
    it "redirects to the sub show page on success" do
      s = Sub.create!(title: Faker::Name.name, description: Faker::Lorem.sentence(word_count: 5), moderator: User.last )
      put :update, :params => { id: s.id, :sub => { :title => "New-title" } }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/subs/#{ActiveSupport::Inflector.parameterize(s.title)}")
    end
  end

  describe "DELETE #destroy" do
    it "redirects to the subs index page on success" do
      s = Sub.create!(title: Faker::Name.name, description: Faker::Lorem.sentence(word_count: 5), moderator: User.last )
      delete :destroy, params: { id: s.id }
      expect(response).to have_http_status(302)
      expect(response).to redirect_to("/subs")
    end
  end
end
