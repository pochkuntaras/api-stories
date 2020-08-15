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
FactoryBot.define do
  factory :article do
    story

    sequence(:name) do |n|
      "My article #{n}"
    end

    text { "My text." }
    kind { "standard_text" }

    Article::KINDS.each do |kind|
      trait(kind) do
        self.kind { kind }
      end
    end
  end

  factory :invalid_article, class: Article do
    story
    name { nil }
    text { "My text of invalid article." }
    kind { "interview" }
  end

  factory :updated_article, class: Article do
    story

    sequence(:name) do |n|
      "My updated article #{n}"
    end

    text { "My updated text." }
    kind { "photo_album" }
  end
end
