# == Schema Information
#
# Table name: questions
#
#  id         :integer          not null, primary key
#  text       :string(255)
#  event_id   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Question < ActiveRecord::Base
  attr_accessible :event_id, :text
end
