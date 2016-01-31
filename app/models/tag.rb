class Tag < ActiveRecord::Base
  has_many :challenge_tags, dependent: :destroy
  has_many :challenges, through: :challenge_tags

  validates :name, presence: true
  validates :name, uniqueness: true
  validates :name, inclusion: { in: [
    'accessibility', 'api', 'auth & service', 'cms', 'css', 'database',
    'environments & server', 'git', 'javascript', 'misc', 'mobile/hybrid',
    'php', 'task runners', 'terminal/shell'
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
