user_one = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')

challenge_one = user_one.challenges.create!(name: 'test', short_description: 'test', long_description: 'longer test')
