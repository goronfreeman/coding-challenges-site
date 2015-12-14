user_one = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')

challenge_one = user_one.challenges.create!(name: 'Lorem Ipsum', short_description: 'Dolor sit amet.', long_description: 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')

tags = ['Accessibility', 'API', 'Auth & Service',
        'CMS', 'CSS', 'Database', 'Environments & Server', 'Git', 'JavaScript',
        'Misc', 'Mobile/Hybrid', 'PHP', 'Task Runners', 'Terminal/Shell']

tags.each do |tag|
  Tag.create(name: tag)
end

challenge_one.challenge_tags.create(tag_id: 1)
