class MessagesController < ApplicationController
  before_filter :set_search
  helper_method :sort_column, :sort_direction

  # NOTE: 表示 検索
  def index
    @messages = Message.all
    @messages = Message.message_list
    @message = Message.new
    #@search = Message.ransack(params[:q])
    #@search.build_sort if @search.sorts.empty?
    @q = Message.search(params[:q])
    @messages = @q.result(distinct: true)
    #@messages = Message.order(params[:sort] + ' ' + params[:direction])
    #@orders = Message.order(params[:sortway])
    @messages = Message.page(params[:page])
    if params[:all].present?
      @messages = @messages.page(params[:page])
    else
      @messages = @messages.page(params[:page]).per(5)
    end
  end

  # NOTE:書き込み
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to action: :index
    else
      @messages = Message.message_list
      render :index
    end
  end

  def set_search
    @search = Message.search(params[:q])
  end

  private

  def message_params
    params.require(:message)
      .permit(
        :title,
        :body
      )
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def sort_column
    Message.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  #def search
  #params[:q] ||= {}
  #params[:q][:s] = %w(author_id category_name created) # 複数指定は配列を渡す
  #@q = Message.search params[:q]
  #@q.result
  #end

  # 削除
  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to :action => :index
    #@posting.errors.messages
  end
end
