class Tag < ActiveRecord::Base
  has_and_belongs_to_many :challenges, join_table: 'challenges_tags', foreign_key: 'tag_id', association_foreign_key: 'challenge_id'
end

# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
