class Event < ActiveRecord::Base
  attr_accessible :description, :max_questions, :name, :user_id
end
