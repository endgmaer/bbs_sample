class MessagesController < ApplicationController


# 表示 検索
  def index
    @messages = Message.message_list
    @message = Message.new
    @search = Message.search(params[:q])
    @topics = @search.result
    @q = Message.with_keywords(params.dig(:q, :keywords)).ransack(params[:q])
    @keywords = @q.result
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @messages }
    end
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

  # 削除
  def destroy
    @messages = Message.find(params[:board_id])
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to messages_list(@messages)
  end

end
