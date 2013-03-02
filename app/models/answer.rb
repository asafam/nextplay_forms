class Answer < ActiveRecord::Base
  attr_accessible :question_id, :text

  belongs_to :answer
end
