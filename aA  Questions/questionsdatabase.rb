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

class Users 
  
  def self.all
    users_data = QuestionsDatabase.instance.execute("SELECT * FROM users")
    users_data.map { |user_row| Users.new(user_row)}
  end

  def self.find_by_id(id)
    self.all.each do |user_row|
      if user_row.id == id  
      return user_row
      end
    end
    nil
  end

  def self.find_by_name(fname, lname)
    self.all.each do |user_row|
      if user_row.fname == fname && user_row.lname == lname
        return user_row
      end
    end
    nil
  end

  attr_accessor :id, :fname, :lname
  def initialize(options)
    @id = options['id']
    @fname = options['fname']
    @lname = options['lname']
  end
end

class Questions 
  
  def self.all
    q_data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    q_data.map { |q_row| Questions.new(q_row)}
  end

  def self.find_by_id(id)
    self.all.each do |q_row|
      if q_row.id == id  
        return q_row            
      end
    end
    nil
  end

  def self.find_by_title(title)
    self.all.each do |q_row|
      if q_row.title == title
        return q_row
      end
    end
    nil
  end

  def self.find_by_author_id(author_id)
   
    question = QuestionsDatabase.instance.execute(<<-SQL, author_id)
      SELECT
        *
      FROM
        questions
      WHERE
        author_id = ?
    SQL

    return nil unless question.length > 0

    Questions.new(question.first) # question is stored in an array!
  
  end

  attr_accessor :id, :title, :body, :author_id
  def initialize(options)
    @id = options['id']
    @title = options['title']
    @body = options['body']
    @author_id = options ['author_id']
  end
end


class QuestionsFollows 
  
  def self.all
    qf_data = QuestionsDatabase.instance.execute("SELECT * FROM questions")
    qf_data.map { |qf_row| Questions.new(qf_row)}
  end

  def self.find_by_id(id)
    self.all.each do |qf_row|
      if qf_row.id == id  
        return qf_row
      end
    end
    nil
  end


  attr_accessor :id
  def initialize(options)
    @id = options['id']
  end
end

class Replies 
  
  def self.all
    replies_data = QuestionsDatabase.instance.execute("SELECT * FROM replies")
    replies_data.map { |r_row| Replies.new(r_row)}
  end

  def self.find_by_id(id)
    self.all.each do |r_row|
      if r_row.id == id  
        return r_row
      end
    end
    nil
  end

  def self.find_by_user_id(user_id)
   
    reply = QuestionsDatabase.instance.execute(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        user_id = ?
    SQL

    return nil unless reply.length > 0

    Replies.new(reply.first) # reply is stored in an array!
  
  end

  def self.find_by_question_id(q_id)
   
    replies = QuestionsDatabase.instance.execute(<<-SQL, q_id)
      SELECT
        *
      FROM
        replies
      WHERE
        q_reply_id = ?
    SQL

    return nil unless replies.length > 0

    replies.map do |reply|
      Replies.new(reply) # reply is stored in an array!
    end

  end


  attr_accessor :id, :q_reply_id, :parent_reply_id, :author_reply_id, :body 
  def initialize(options)
    @id = options['id']
    @q_reply_id = options['q_reply_id']
    @parent_reply_id = options['parent_reply_id']
    @author_reply_id = options['author_reply_id']
    @body = options['body']
  end
end

class QuestionLikes 
  
  def self.all
    qlikes_data = QuestionsDatabase.instance.execute("SELECT * FROM question_likes")
    qlikes_data.map { |qlikes_row| QuestionLikes.new(qlikes_row)}
  end

  def self.find_by_id(id)
    self.all.each do |qlikes_row|
      if qlikes_row.id == id  
        return qlikes_row
      end
    end
    nil
  end


  attr_accessor :id, :if_like, :like_user_id, :like_q_id
  def initialize(options)
    @id = options['id']
    @if_like= options['if_like']
    @like_user_id = options['like_user_id']
    @like_q_id = options['like_q_id']
  end
end