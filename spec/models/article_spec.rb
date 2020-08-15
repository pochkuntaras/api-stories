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
end
