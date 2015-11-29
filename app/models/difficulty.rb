class Difficulty < ActiveRecord::Base
  has_many :challenges
end

# == Schema Information
#
# Table name: difficulties
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
