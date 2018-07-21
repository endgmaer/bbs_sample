class MessagesController < ApplicationController
  #before_action :set_s 
  helper_method :sort_column, :sort_direction

# 表示 検索
  def index
    @messages = Message.all
    #@messages = Message.message_list
    @message = Message.new
    @messages = Message.all.order(params[:sort])
    #@search = Message.ransack(params[:q])
    #@search.build_sort if @search.sorts.empty?
    @q = Message.search(params[:q])
    @q.sorts = 'id asc' if @q.sorts.empty?
    @messages = @q.result(distinct: true)
    #@messages = Message.all.order(sort_column + ' ' + sort_direction)
    #@orders = Message.order(params[:sortway])
    @messages = Message.all.order(params[:sort])
    @messages = Message.page(params[:page])
    if params[:all].present?
       @messages = @messages.page(params[:page])
    else
       @messages = @messages.page(params[:page]).per(5)
    end
  end

  #def new
   # @message = Message.new(flash[:all])
  #end #エラー出たからコメントアウト

  # 書き込み
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to action: :index
    else
      redirect_to messages_path, flash: {
          message: @message,
          error_messages: @message.errors.full_messages
      }
    end
  end




 # 削除
  def destroy
    @message = Message.find(params[:id])
    @message.delete
    redirect_to message_index_path
    #@posting.errors.messages
  end


  
  def set_search
    @q = Message.search(params[:q])
  end

  private

  def message_params
    params.require(:message).permit(
        :title,
        :deletepwd,
        :body
    )
  end

  #def sort_direction
   # %w[asc desc].include?(params[:direction]) ?  params[:direction] : "asc"
  #end

  #def sort_column
   #   Message.column_names.include?(params[:sort]) ? params[:sort] : "name"
  #end


  #def search
    #params[:q] ||= {}
    #params[:q][:s] = %w(author_id category_name created) # 複数指定は配列を渡す
    #@q = Message.search params[:q]
    #@q.result
  #end
end
