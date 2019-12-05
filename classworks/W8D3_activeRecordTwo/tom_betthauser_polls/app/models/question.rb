class Question < ApplicationRecord
    validates :text, presence: true

    has_many :answer_choices, 
        class_name: 'AnswerChoice',
        primary_key: :id,
        foreign_key: :question_id

    has_many :responses, 
        through: :answer_choices,
        source: :responses
    
    belongs_to :poll,
        primary_key: :id,
        foreign_key: :poll_id,
        class_name: 'Poll'

end