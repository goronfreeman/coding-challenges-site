class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :challenge

  validates :user_id, :challenge_id, :body, presence: true
end

# == Schema Information
#
# Table name: comments
#
#  id           :integer          not null, primary key
#  body         :text(65535)
#  challenge_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
