class Message < ActiveRecord::Base
  validates :title, :presence => true, :length => { :maximum => 20 }
  validates :password, :presence => true, :length => { :minimum => 6 }
  validates :body, :presence => true, :length => { :maximum => 250 }
  #validates :deletepwd, 
	#format: { with:message.delete "パスワードは半角英数のみ利用できます"},
	#presence: { message: "パスワードを入力してください" },
	#length: { maximum: 10, message: "パスワードは１０文字までです" }
  def self.message_list
    return Message.all.order(:created_at => :desc)
  end


end
