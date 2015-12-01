class CompletedChallenge < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  validates :user_id, :challenge_id, presence: true
end

# == Schema Information
#
# Table name: completed_challenges
#
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :integer
#  challenge_id :integer
#
