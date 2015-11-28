user_one = User.create!(email: 'test@test.com', password: 'password', password_confirmation: 'password')

# tag_css = Tag.create(name: 'css')
# tag_css.save!
#
difficulty_easy = Difficulty.create!(id: 1, name: 'easy')
# difficulty_medium = Difficulty.create(id: 2, name: 'medium')
# difficulty_hard = Difficulty.create(id: 3, name: 'hard')

challenge_one = user_one.challenges.build(name: 'test', short_description: 'test', long_description: 'longer test', difficulty: difficulty_easy)
puts challenge_one
