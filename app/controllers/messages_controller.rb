class MessagesController < ApplicationController
  

# 表示 検索
  def index
    @messages = Message.all
    @messages = Message.message_list
    @message = Message.new
    @search = Message.search(params[:q])
    #@search.build_sort if @search.sorts.empty?
    #@topics = @search.result
    @q = Message.search(params[:q])
    @messages = @q.result(distinct: true)
    @messages = Message.page(params[:page]).per(5)
      if params[:all]#なぜallが反映されないか不明
         @messages = @messages.per(Message.count) 
         # you can also hardcod' it
      end
    
    #respond_to do |format|
      #format.html # index.html.erb
      #format.json { render json: @messages }
    #end
  end

  #def search
    #params[:q] ||= {}
    #params[:q][:s] = %w(author_id category_name created) # 複数指定は配列を渡す
    #@q = Message.search params[:q]
    #@q.result
  #end

  # 書き込み
  def create
    @message = Message.create(params.require(:message)
      .permit(:title, :password, :body))
    if @message.save
      
    else
      @messages = Message.message_list
      render :index
    end
  end

  # 削除
  def destroy
    @message = Message.find(params[:id])
    @message.delete
    redirect_to :action => :index
    #@posting.errors.messages
  end

end
