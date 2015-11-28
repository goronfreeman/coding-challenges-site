user_one = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')

tag_css = Tag.create!(name: 'css')

difficulty_easy = Difficulty.create!(name: 'easy')
difficulty_medium = Difficulty.create!(name: 'medium')
difficulty_hard = Difficulty.create!(name: 'hard')

challenge_one = user_one.challenges.build(name: 'test', short_description: 'test', long_description: 'longer test', difficulty: difficulty_easy)
challenge_one.save!
