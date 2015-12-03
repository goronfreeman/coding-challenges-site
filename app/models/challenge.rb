class Challenge < ActiveRecord::Base
  belongs_to :user
  has_many :user_completions, class_name: 'CompletedChallenge'
  has_many :challenge_tags
  has_many :tags, through: :challenge_tags

  validates :name, :short_description, :long_description, :user_id, :difficulty, presence: true
  # validate :challenge_must_have_at_least_one_tag, on: :create

  enum difficulty: [:easy, :medium, :hard]

  def challenge_must_have_at_least_one_tag
    if tags.count < 1
      errors.add(:base, 'must have at least one tag')
    end
  end
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
#  difficulty        :integer          default(0)
#
