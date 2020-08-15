require 'rails_helper'

RSpec.describe StoriesController, type: :controller do
  describe 'GET #index' do
    let(:first_story)  { create :story, name: 'The first story.' }
    let(:second_story) { create :story, name: 'The second story.' }

    let!(:stories) { [first_story, second_story] }

    describe 'Response.' do
      before { do_request }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:stories)).to match_array(stories) }
      it { expect(response.body).to have_json_size(2).at_path('stories') }
      it { expect(response.body).to be_json_eql(stories.to_json).at_path('stories') }
    end

    def do_request(params = {})
      get :index, params: { format: :json }.merge(params)
    end
  end

  describe 'GET #show' do
    let(:story)  { create :story, name: 'The my story.' }

    context 'Response.' do
      before { do_request }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to be_json_eql(story.to_json).at_path('story') }
    end

    def do_request
      get :show, params: { id: story, format: :json }
    end
  end

  describe 'POST #create' do
    context 'With valid attributes.' do
      let(:attributes) { attributes_for(:story) }

      it { expect { do_request }.to change(Story, :count).by(1) }

      context 'Response.' do
        before { do_request }

        it { expect(response.body).to be_json_eql(attributes.to_json).at_path('story') }
        it { expect(response).to have_http_status(:created) }
      end
    end

    context 'With invalid attributes.' do
      let(:attributes) { attributes_for(:invalid_story) }

      it { expect { do_request }.to_not change(Story, :count) }

      context 'Response.' do
        let(:errors) {{ name: ["can't be blank"] }}

        before { do_request }

        it { expect(response.body).to be_json_eql(errors.to_json).at_path('errors') }
        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    def do_request
      post :create, params: { story: attributes, format: :json }
    end
  end

  describe 'PATCH #update' do
    let!(:story) { create :story }

    before do
      do_request
      story.reload
    end

    context 'With valid attributes.' do
      let(:attributes) { attributes_for(:updated_story) }

      it { expect(story.name).to eq(attributes[:name]) }
      it { expect(response).to have_http_status(:no_content) }
    end

    context 'With invalid attributes.' do
      let(:attributes) { attributes_for(:invalid_story) }

      it { expect(story.name).to_not eq(attributes[:name]) }
      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    def do_request
      patch :update, params: { id: story, story: attributes, format: :json }
    end
  end

  describe 'DELETE #destroy' do
    let!(:story) { create :story }

    it { expect { do_request }.to change(Story, :count).by(-1) }

    context 'Response.' do
      before { do_request }

      it { expect(response).to have_http_status(:no_content) }
    end

    def do_request
      delete :destroy, params: { id: story, format: :json }
    end
  end
end
