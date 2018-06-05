class Message < ActiveRecord::Base
  validates :title, :presence => true, :length => { :maximum => 20 }
  # validates :deletepwd, :presence => true, :length => { :minimum => 6 }
  validates :body, :presence => true, :length => { :maximum => 250 }

  def self.message_list
    return Message.all.order(:created_at => :desc)
  end


end
