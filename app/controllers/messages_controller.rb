class MessagesController < ApplicationController

  # 表示
  def index
    @messages = Message.message_list
    @message = Message.new
  end

  # 書き込み
  def create
    @message = Message.new(params.require(:message).permit(:title, :body))
    if @message.save
      redirect_to :action => :index
    else
      @messages = Message.message_list
      render :index
    end
  end

end
