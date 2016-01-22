class Tag < ActiveRecord::Base
  has_many :challenge_tags, dependent: :destroy
  has_many :challenges, through: :challenge_tags

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, inclusion: { in: [
    'Accessibility', 'API', 'Auth & Service', 'CMS', 'CSS', 'Database',
    'Environments & Server', 'Git', 'JavaScript', 'Misc', 'Mobile/Hybrid',
    'PHP', 'Task Runners', 'Terminal/Shell'
  ] }
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
