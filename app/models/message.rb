class Message < ActiveRecord::Base
  validates :title, :presence => true, :length => { :maximum => 20 }
  #validates :deletepwd, :presence => true, :length => { :minimum => 6 }
  validates :body, :presence => true, :length => { :maximum => 250 }
  #validates :deletepwd, 
	#presence: { message: "パスワードを入力してください" },
	#length: { maximum: 10, message: "パスワードは１０文字までです" }
  

  #def self.message_list
   # return Message.all.order(:created_at => :desc)
  #end
#end

  #if(params[:sortway]=="Order By Desc")
   #   @messages=@messages.order(params[:sorttitle] => :desc)
    #else
     # @messages=@messages.order(params[:sorttitle] => :asc)
    #end

  #コントローラ用一時避難
  #　　<div>
#<%= form_for @orders do |f| %>
#<%= select_tag(:sorttitle, options_for_select(["新着順","acs"], ["名前順","title"], ["古い順","desc"])) %>
#<%= select_tag(:sortway, options_for_select(["Order By Asc","Order By Desc"])) %>
#<%= submit_tag"Sort Messages", class:"btn btn-info"  %>
#</div>


end

  # if(params[:sortway] == "Order By Desc")
	 #  @messages = @messages.order(params[:sorttitle] => :desc)
  # else
	 #  @messages = @messages.order(params[:sorttitle] => :asc)
  # end

#view
# <div>
# <%= select_tag(:sorttitle, options_for_select(["新着順","acs"], ["名前順","name"], ["古い順","desc"])) %>
# <%= select_tag(:sortway, options_for_select(["Order By Asc","Order By id","Order By Desc"])) %>
# <%= submit_tag"並び替え", class:"message" %>
# </div>
