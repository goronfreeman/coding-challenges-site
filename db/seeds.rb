user_one = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')

challenge_one = user_one.challenges.create!(name: 'Lorem Ipsum', short_description: 'dolor sit amet.', long_description: 'consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.')

tag_one = challenge_one.tags.create!(name: 'css')
