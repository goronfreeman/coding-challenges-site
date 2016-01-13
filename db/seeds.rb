user_one = User.create!(email: 'test@test.com',
                        username: 'testy',
                        password: 'password',
                        password_confirmation: 'password')



challenge_one = user_one.challenges.create!(name: 'Lorem Ipsum',
                                            short_description: 'Dolor sit amet.',
                                            long_description: 'Consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                                            difficulty: 'easy')

comment_one = user_one.comments.create!(body: "I just don't understand why people would buy things like this. I mean, what value does it have, to own a plate with a President's face on it. Where's the utility? What's the aesthetic appeal? Are you just SUCH a fanboi for Presidents you need to capture them on plates?",
                                        challenge_id: challenge_one.id,
                                        user_id: user_one.id)

tags = ['Accessibility', 'API', 'Auth & Service',
        'CMS', 'CSS', 'Database', 'Environments & Server', 'Git', 'JavaScript',
        'Misc', 'Mobile/Hybrid', 'PHP', 'Task Runners', 'Terminal/Shell']

tags.each do |tag|
  Tag.create(name: tag)
end

challenge_one.challenge_tags.create(tag_id: 1)
