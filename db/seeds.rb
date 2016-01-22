# Create tag list
tags = [
  'Accessibility', 'API', 'Auth & Service', 'CMS', 'CSS', 'Database',
  'Environments & Server', 'Git', 'JavaScript', 'Misc', 'Mobile/Hybrid',
  'PHP', 'Task Runners', 'Terminal/Shell'
]

tags.each do |tag|
  Tag.create!(name: tag)
end

# Create user
user_one = User.create!(
  email: 'test@test.com',
  username: 'testy',
  password: 'password',
  password_confirmation: 'password'
)

# Create challenge
challenge_one = user_one.challenges.create!(
  name: 'Lorem Ipsum',
  short_description: 'Dolor sit amet.',
  long_description: "Consectetur adipisicing elit, sed do eiusmod tempor\n
                     incididunt ut labore et dolore magna aliqua.",
  difficulty: 'easy',
  challenge_tags_attributes: [
    { tag_id: 1 }
  ]
)

# Create comment
user_one.comments.create!(
  body: "I just don't understand why people would buy things like this. I\n
         mean,what value does ithave, to own a plate with a President's face\n
         on it. Where's the utility? What's the aesthetic appeal? Are you just\n
         SUCH a fanboi for Presidents you need to capture them on plates?",
  challenge_id: challenge_one.id,
  user_id: user_one.id
)
