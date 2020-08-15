# == Schema Information
#
# Table name: articles
#
#  id         :bigint           not null, primary key
#  kind       :string           default("standard_text"), not null
#  name       :string           not null
#  text       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  story_id   :bigint           not null
#
# Indexes
#
#  index_articles_on_kind      (kind)
#  index_articles_on_name      (name)
#  index_articles_on_story_id  (story_id)
#
# Foreign Keys
#
#  fk_rails_...  (story_id => stories.id)
#
require 'rails_helper'

RSpec.describe Article, type: :model do
  subject { create :article }

  describe 'Associations.' do
    it { should belong_to(:story).required(true) }
  end

  describe 'Validations.' do
    it { should validate_presence_of :story_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :text }

    context 'Kind.' do
      let(:kinds) { %i[standard_text photo_album interview sentence event] }

      it { should enumerize(:kind).in(kinds).with_predicates(true).with_default(:standard_text) }
    end
  end

  describe 'Scopes.' do
    context '#story' do
      let(:first_story) { create :story }
      let(:second_story) { create :story }

      let(:first_article)  { create :article, name: 'The first article.', story: first_story  }
      let(:second_article) { create :article, name: 'The second article.', story: second_story }
      let(:thirty_article) { create :article, name: 'The thirty article.' }

      it { expect(Article.story(nil)).to match_array([]) }
      it { expect(Article.story(first_story.id)).to match_array(first_article) }
      it { expect(Article.story(second_story.id)).to match_array(second_article) }
    end

    context '#named' do
      let(:first_article)  { create :article, name: 'The first article.' }
      let(:second_article) { create :article, name: 'The second article.' }

      it { expect(Article.named('article')).to match_array([first_article, second_article]) }
      it { expect(Article.named('first')).to match_array(first_article) }
      it { expect(Article.named('second')).to match_array(second_article) }
    end

    context '#text' do
      let!(:first_article)  { create :article, text: "The most largest continent is Eurasia." }
      let!(:second_article) { create :article, text: "Neil is river." }

      it { expect(Article.text("is")).to match_array([first_article, second_article]) }
      it { expect(Article.text("largest")).to match_array(first_article) }
      it { expect(Article.text("neil")).to match_array(second_article) }
    end

    context '#kind' do
      let!(:first_article)  { create :article, :standard_text, text: "The most largest continent is Eurasia" }
      let!(:second_article) { create :article, :interview, text: "Neil is river." }

      it { expect(Article.kind(nil)).to match_array([]) }
      it { expect(Article.kind("standard_text")).to match_array(first_article) }
      it { expect(Article.kind("interview")).to match_array(second_article) }
    end
  end
end
