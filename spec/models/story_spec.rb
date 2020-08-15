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
require 'rails_helper'

RSpec.describe Story, type: :model do
  subject { create :story }

  describe 'Associations.' do
    it { should have_many(:articles).dependent(:destroy) }
  end

  describe 'Validations.' do
    it { should validate_presence_of :name }

    it { should validate_uniqueness_of :name }
  end
end
