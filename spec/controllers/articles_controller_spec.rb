require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do
  describe 'GET #index' do
    let(:first_article)  { create :article, name: 'The first article.' }
    let(:second_article) { create :article, name: 'The second article.' }

    let!(:articles) { [first_article, second_article] }

    describe 'Response.' do
      let(:articles_json) { articles.to_json(include: :story, except: :story_id) }

      before { do_request }

      it { expect(response).to have_http_status(:ok) }
      it { expect(assigns(:articles)).to match_array(articles) }
      it { expect(response.body).to have_json_size(2).at_path('articles') }
      it { expect(response.body).to be_json_eql(articles_json).at_path('articles') }
    end

    def do_request(params = {})
      get :index, params: { format: :json }.merge(params)
    end
  end

  describe 'GET #show' do
    let(:article)  { create :article, name: 'The my article.' }

    context 'Response.' do
      let(:article_json) { article.to_json(include: :story, except: :story_id) }

      before { do_request }

      it { expect(response).to have_http_status(:ok) }
      it { expect(response.body).to be_json_eql(article_json).at_path('article') }
    end

    def do_request
      get :show, params: { id: article, format: :json }
    end
  end

  describe 'POST #create' do
    let(:story) { create :story, name: 'The my story.' }
    let(:article_attributes) { attributes_for(:article) }

    context 'With valid attributes.' do
      let(:attributes) { article_attributes.merge(story_id: story.id) }

      it { expect { do_request }.to change(Article, :count).by(1) }

      context 'Response.' do
        let(:article_json) { article_attributes.merge(story: { name: story.name }).to_json }

        before { do_request }

        it { expect(response.body).to be_json_eql(article_json).at_path('article') }
        it { expect(response).to have_http_status(:created) }
      end
    end

    context 'With invalid attributes.' do
      let(:attributes) { attributes_for(:invalid_article).merge(story_id: story.id) }

      it { expect { do_request }.to_not change(Article, :count) }

      context 'Response.' do
        let(:errors) {{ name: ["can't be blank"] }}

        before { do_request }

        it { expect(response.body).to be_json_eql(errors.to_json).at_path('errors') }
        it { expect(response).to have_http_status(:unprocessable_entity) }
      end
    end

    def do_request
      post :create, params: { article: attributes, format: :json }
    end
  end

  describe 'PATCH #update' do
    let(:story) { create :story, name: 'The my story.' }

    let!(:article) { create :article }

    before do
      do_request
      article.reload
    end

    context 'With valid attributes.' do
      let(:attributes) { attributes_for(:updated_article).merge(story_id: story.id) }

      it 'should change parameters of the article' do
        expect(article.story_id).to eq(attributes[:story_id])
        expect(article.name).to eq(attributes[:name])
        expect(article.text).to eq(attributes[:text])
        expect(article.kind).to eq(attributes[:kind])
      end

      it { expect(response).to have_http_status(:no_content) }
    end

    context 'With invalid attributes.' do
      let(:attributes) { attributes_for(:invalid_article).merge(story_id: story.id) }

      it 'should not change parameters of the article' do
        expect(article.story_id).to_not eq(attributes[:story_id])
        expect(article.name).to_not eq(attributes[:name])
        expect(article.text).to_not eq(attributes[:text])
        expect(article.kind).to_not eq(attributes[:type])
      end

      it { expect(response).to have_http_status(:unprocessable_entity) }
    end

    def do_request
      patch :update, params: { id: article, article: attributes, format: :json }
    end
  end

  describe 'DELETE #destroy' do
    let!(:article) { create :article }

    it { expect { do_request }.to change(Article, :count).by(-1) }

    context 'Response.' do
      before { do_request }

      it { expect(response).to have_http_status(:no_content) }
    end

    def do_request
      delete :destroy, params: { id: article, format: :json }
    end
  end
end
