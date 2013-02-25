class Question < ActiveRecord::Base
  attr_accessible :text, :user_id
  
  belongs_to :user

  validate :text, :length => { :maximum => 100 }
end
