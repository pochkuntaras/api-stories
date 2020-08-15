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
class Story < ApplicationRecord
  has_many :articles, dependent: :destroy

  validates :name, presence: true, uniqueness: true
end
