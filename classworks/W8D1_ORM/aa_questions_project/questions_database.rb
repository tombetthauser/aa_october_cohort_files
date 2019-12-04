require 'sqlite3'
require 'singleton'
class QuestionsDatabase < SQLite3::Database 
    include Singleton
    
    def initialize
      super('questions.db')
      self.type_translation = true
      self.results_as_hash = true   
    end
end


class Question

  attr_accessor :id, :title, :body, :author_id

  def self.find_by_author_id(author_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
        SQL
        return nil unless data.length > 0
        data.map { |datum| Question.new(datum) }
      end
      
      def initialize(options)
        @id = options['id']
        @title = options['title']
        @body  = options['body']
        @author_id = options['author_id']
      end

      def author
        data = QuestionsDatabase.instance.execute(<<-SQL, self.author_id)
            SELECT
              *
            FROM
              users
            WHERE
              id = ?
        SQL
        User.new(data.first)
      end

      def replies
        Reply.find_by_question_id(self.id)
      end

    def followed_questions 
      QuestionFollow.followers_for_question_id(self.id)
    end
end
    
    
class Reply
      
 attr_accessor :id, :body, :subject_id, :user_reply_id, :parent_reply_id
      
  def self.find_by_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM
          replies
        WHERE
          user_reply_id = ?  
    SQL
    return nil unless data.length > 0
    data.map { |datum| Reply.new(datum) }
  end

  def self.find_by_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM
          replies
        WHERE
          subject_id = ?
    SQL
    return nil unless data.length > 0
    data.map { |datum| Reply.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @body = options['body']
    @subject_id = options['subject_id']
    @user_reply_id = options['user_reply_id']
    @parent_reply_id = options['parent_reply_id']
  end

  def author
    data = QuestionsDatabase.instance.execute(<<-SQL, self.user_reply_id)
        SELECT
          *
        FROM
          users
        WHERE
          id = ?
    SQL
    User.new(data.first)
  end

  def question
    data = QuestionsDatabase.instance.execute(<<-SQL, self.subject_id)
        SELECT
          *
        FROM
          users
        WHERE
          id = ?
    SQL
    User.new(data.first)
  end

  def parent_reply 
    data = QuestionsDatabase.instance.execute(<<-SQL, self.parent_reply_id)
      SELECT
        *
      FROM
        replies
      WHERE
        id = ?
    SQL
    return nil if data.empty?
    Reply.new(data.first)
  end

  def child_replies
    data = QuestionsDatabase.instance.execute(<<-SQL, self.id)
      SELECT
        *
      FROM
        replies
      WHERE
        parent_reply_id = ?
    SQL
    return nil if data.empty?
    data.map { |datum| Reply.new(datum) }
  end

end


class User

  attr_accessor :id, :fname, :lname

  def self.find_by_name(fname, lname)
    data = QuestionsDatabase.instance.execute(<<-SQL, fname, lname)
        SELECT
          *
        FROM
          users
        WHERE
          fname = ? AND lname = ?
    SQL
    return nil unless data.length > 0
    data.map { |datum| User.new(datum) }
  end

  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end

  def authored_questions
    Question.find_by_author_id(self.id)
  end

  def authored_replies
    Reply.find_by_user_id(self.id)
  end

  def followed_questions 
    QuestionFollow.followed_questions_for_user_id(self.id)
  end


end


class QuestionFollow

  attr_accessor :id, :users_id, :questions_id

  def self.followers_for_question_id(question_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, question_id)
        SELECT
          *
        FROM
          users
        JOIN
          question_follows ON users.id = question_follows.users_id
        WHERE
          question_follows.questions_id = ?
    SQL
    return nil unless data.length > 0
    data.map { |datum| User.new(datum) }
  end

  def self.followed_questions_for_user_id(user_id)
    data = QuestionsDatabase.instance.execute(<<-SQL, user_id)
        SELECT
          *
        FROM
          questions
        JOIN
          question_follows ON questions.id = question_follows.questions_id
        WHERE
          question_follows.users_id = ?
    SQL
    return nil unless data.length > 0
    data.map { |datum| Question.new(datum) }
  end

  def self.most_followed_questions(n)
       data = QuestionsDatabase.instance.execute(<<-SQL, n)
        SELECT
          *
        FROM
          questions
        WHERE
          questions.title IN (
          SELECT
            questions.title
          FROM
            questions
          JOIN
            question_follows ON questions.id = question_follows.questions_id
          GROUP BY
            questions.title
          ORDER BY
            COUNT(question_follows.questions_id) DESC
          LIMIT ?
        ) 
    SQL
    return nil unless data.length > 0
    data.map { |datum| Question.new(datum) }

  end

  def initialize(options)
    @id = options['id']
    @users_id = options['users_id']
    @questions_id = options['questions_id']
  end

end