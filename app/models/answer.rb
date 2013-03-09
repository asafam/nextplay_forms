# == Schema Information
#
# Table name: answers
#
#  id          :integer          not null, primary key
#  text        :string(255)
#  question_id :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Answer < ActiveRecord::Base
  attr_accessible :question_id, :text

  belongs_to :answer
end
