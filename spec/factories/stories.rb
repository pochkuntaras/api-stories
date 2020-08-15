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
FactoryBot.define do
  factory :story do
    sequence(:name) { |n| "My story #{n}" }
  end

  factory :invalid_story, class: Story do
    name { nil }
  end

  factory :updated_story, class: Story do
    sequence(:name) { |n| "My updated story #{n}" }
  end
end
