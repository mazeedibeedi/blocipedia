require 'rails_helper'

RSpec.describe WikisController, type: :controller do
  let(:my_user) { create(:user) }
  let(:my_wiki) { create(:wiki, user: my_user) }

  describe "GET #index" do
    it "returns http success" do
      sign_in my_user
      get :index
      expect(response).to have_http_status(:success)
    end

    it "assigns my_wiki to @wikis" do
      sign_in my_user
      get :index
      expect(assigns(:wikis)).to eq([my_wiki])
    end
  end

  describe "GET #new" do
    it "returns http success" do
      sign_in my_user
      get :new
      expect(response).to have_http_status(:success)
    end

    it "renders the #new view" do
      sign_in my_user
      get :new
      expect(response).to render_template(:new)
    end

    it "initializes @wiki" do
      sign_in my_user
      get :new
      expect(assigns(:wiki)).not_to be_nil
    end
  end

  describe "POST #create" do
    it "increases the number of wikis by 1" do
      sign_in my_user
      expect{ post :create, {wiki: {title: "My Title", body: "My Body", private: true, user: my_user}}}.to change(Wiki,:count).by(1)
    end

    it "assigns Wiki.last to @wiki" do
      sign_in my_user
      post :create, {wiki: {title: "My title", body: "My body", private: true, user: my_user}}
      expect(assigns(:wiki)).to eq Wiki.last
    end

    it "redirects to the new wiki" do
      sign_in my_user
      post :create, {wiki: {title: "My title", body: "My body", private: true, user: my_user}}
      expect(response).to redirect_to Wiki.last
    end
  end

  describe "GET #show" do
    it "returns http success" do
      sign_in my_user
      get :show, { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #show view" do
      sign_in my_user
      get :show, { id: my_wiki.id }
      expect(response).to render_template(:show)
    end

    it "assigns my_wiki to @wiki" do
      sign_in my_user
      get :show, { id: my_wiki.id }
      expect(assigns(:wiki)).to eq my_wiki
    end
  end

  describe "GET #edit" do
    it "returns http success" do
      sign_in my_user
      get :edit, { id: my_wiki.id }
      expect(response).to have_http_status(:success)
    end

    it "renders the #edit view" do
      sign_in my_user
      get :edit, { id: my_wiki.id }
      expect(response).to render_template(:edit)
    end

    it "assigns wiki to be updated to @wiki" do
      sign_in my_user
      get :edit, { id: my_wiki.id }
      wiki_instance = assigns(:wiki)

      expect(wiki_instance.id).to eq my_wiki.id
      expect(wiki_instance.title).to eq my_wiki.title
      expect(wiki_instance.body).to eq my_wiki.body
      expect(wiki_instance.private).to eq my_wiki.private
      expect(wiki_instance.user).to eq my_wiki.user
    end
  end

  describe "PUT #update" do
    it "updates wiki with expected attributes" do
      sign_in my_user
      new_title = "new title"
      new_body = "new body"
      new_private = false

      put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body, private: new_private }

      updated_wiki = assigns(:wiki)
      expect(updated_wiki.id).to eq my_wiki.id
      expect(updated_wiki.title).to eq new_title
      expect(updated_wiki.body).to eq new_body
      expect(updated_wiki.private).to eq new_private
    end

    it "redirects to the updated wiki" do
      sign_in my_user
      new_title = "new title"
      new_body = "new body"
      new_private = false

      put :update, id: my_wiki.id, wiki: { title: new_title, body: new_body, private: new_private }
      expect(response).to redirect_to my_wiki
    end
  end

  describe "DELETE #destroy" do
    it "deletes the wiki" do
      sign_in my_user
      delete :destroy, id: my_wiki.id
      count = Wiki.where({id: my_wiki.id}).size
      expect(count).to eq 0
    end

    it "redirects to the wiki index" do
      sign_in my_user
      delete :destroy, id: my_wiki.id
      expect(response).to redirect_to(wikis_path)
    end
  end

end
