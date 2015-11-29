user_one = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')

difficulty_easy = Difficulty.create!(id: 1, name: 'easy')

challenge_one = user_one.challenges.create!(name: 'test', short_description: 'test', long_description: 'longer test', difficulty: difficulty_easy)
