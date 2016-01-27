class ChallengeTag < ActiveRecord::Base
  belongs_to :challenge
  belongs_to :tag

  validates :tag_id, presence: true
  validates :tag_id, uniqueness: true
end

# == Schema Information
#
# Table name: challenge_tags
#
#  id           :integer          not null, primary key
#  challenge_id :integer
#  tag_id       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
