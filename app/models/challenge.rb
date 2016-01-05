class Challenge < ActiveRecord::Base
  enum difficulty: [:easy, :medium, :hard]

  belongs_to :user
  has_many :user_completions, class_name: 'CompletedChallenge'
  has_many :challenge_tags
  has_many :tags, through: :challenge_tags

  validates :name, :short_description, :long_description, :user_id, :difficulty, presence: true
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
#  user_id           :integer
#  difficulty        :integer
#
