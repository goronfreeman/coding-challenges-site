class Challenge < ActiveRecord::Base
  belongs_to :user
  has_one :difficulty
  has_and_belongs_to_many :tags, join_table: 'challenges_tags', foreign_key: 'challenge_id', association_foreign_key: 'tag_id'

  validates :name, :short_description, :long_description, presence: true
end

# == Schema Information
#
# Table name: challenges
#
#  id                :integer          not null, primary key
#  name              :string(255)
#  short_description :text(65535)
#  long_description  :text(65535)
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  difficulty        :integer
#  user_id           :integer
#
