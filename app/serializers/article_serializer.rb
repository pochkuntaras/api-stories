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
class ArticleSerializer < ActiveModel::Serializer
  has_one :story

  attributes :id, :name, :kind, :text, :created_at, :updated_at
end
