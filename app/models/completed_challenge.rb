class CompletedChallenge < ActiveRecord::Base
  has_many :users
  has_many :challenges
end

# == Schema Information
#
# Table name: completed_challenges
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
