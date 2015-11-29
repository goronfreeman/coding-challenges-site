class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :user_completions, class_name: 'CompletedChallenge'
  has_and_belongs_to_many :tags, join_table: 'challenges_tags', foreign_key: 'challenge_id', association_foreign_key: 'tag_id'

  validates :name, :short_description, :long_description, :difficulty, presence: true

  enum difficulty: [:easy, :medium, :hard]
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
#  difficulty_id     :integer
#  difficulty        :integer
#
