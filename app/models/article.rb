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
class Article < ApplicationRecord
  extend Enumerize

  include Filterable

  KINDS = %i[standard_text photo_album interview sentence event].freeze

  belongs_to :story

  validates :story_id, :name, :text, presence: true

  enumerize :kind, in: KINDS, predicates: true, default: :standard_text

  scope :story, -> (name) { where(story_id: Story.select(:id).where('LOWER("stories"."name") LIKE LOWER(?)', "%#{name&.downcase}%")) }
  scope :named, -> (name) { where('LOWER("articles"."name") LIKE LOWER(?)', "%#{name&.downcase}%") }
  scope :text,  -> (text) { where('LOWER("articles"."text") LIKE LOWER(?)', "%#{text&.downcase}%") }
  scope :kind,  -> (kind) { where(kind: kind&.downcase) }

  def self.group_by_field(field = 'id')
    field_sym = field.downcase.to_sym
    where(field_sym => Article.select(field_sym).group(field_sym)).reorder(field_sym)
  end

  def self.meta
    select('"stories"."name" AS story_name',
           'COUNT("articles"."id") AS count_articles',
           'COUNT(DISTINCT "articles"."kind") AS count_kinds',
           '(SELECT "a"."name" FROM "articles" AS a WHERE "a"."id" = MAX("articles"."id")) AS last_created_article'
    ).joins(:story).group('"stories"."name"').as_json(except: :id)
  end
end
