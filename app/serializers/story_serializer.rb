# == Schema Information
#
# Table name: stories
#
#  id         :bigint           not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_stories_on_name  (name) UNIQUE
#
class StorySerializer < ActiveModel::Serializer
  attributes :id, :name, :created_at, :updated_at
end
