# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ActiveRecord::Base.transaction do
    User.destroy_all
    Poll.destroy_all
    Question.destroy_all
    AnswerChoice.destroy_all
    Response.destroy_all
    u1 = User.create!(username: 'jefferson')
    u2 = User.create!(username: 'muenster')

    poll1 = Poll.create!(title: 'boxes.com', author: u1)
    poll2 = Poll.create!(title: 'poll.com', author: u2)

    qu1 = Question.create!(text: 'where is', poll: poll1)
    qu2 = Question.create!(text: 'what is', poll: poll2)

    ans1 = AnswerChoice.create!(text: 'answers1', question: qu1)
    ans2 = AnswerChoice.create!(text: 'answers2', question: qu2)

    res1 = Response.create!(respondent_id: 1, answer_choice: ans1)
    res2 = Response.create!(respondent_id: 2, answer_choice: ans2)
   
end
