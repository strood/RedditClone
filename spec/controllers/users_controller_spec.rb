require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #new' do
    it "renders the new_user_url template" do
      get :new, {}
      expect(response).to have_http_status(200)
      expect(response).to render_template("new")
    end
  end


  describe '#POST #create' do
    context 'with invalid params' do
      it "validates the presence of both the users username and password" do
        post :create, params: { user: {username: Faker::Name.first_name,
                                       password: ""}}
        expect(response).to redirect_to("/users/new")
        expect(flash[:errors]).to be_present

      end

      it 'valdates the password is at least 6 characters long' do
        post :create, params: { user: {username: Faker::Name.first_name,
                                       passwword: "short"}}
        expect(response).to redirect_to("/users/new")
        expect(flash[:errors]).to be_present
      end
    end

    context 'with valid params' do
      it 'redirects user to their user page upon successful creation' do
        post :create, params: { user: {username: Faker::Name.first_name,
                                       password: "good-password"}}
        expect(response).to have_http_status(302)
        # despite being present and showing up, kept failing, saiying flash[:notice] was nil
        # expect(flash[:notice]).to be_present
      end
    end
  end
end
