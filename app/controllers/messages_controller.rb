class MessagesController < ApplicationController
  before_filter :set_search
  helper_method :sort_column, :sort_direction

  # NOTE: 表示 検索
  def index
    @message = Message.new

    @q = Message.search(params[:q])

    @q.sorts = 'created_at asc' if @q.sorts.blank?

    @messages = @q.result

    if params[:all].blank?
      @messages = @messages.page(params[:page]).per(5)
    end

  end

  # NOTE: 書き込み
  def create
    @message = Message.new(message_params)

    if @message.save
      redirect_to action: :index
    else
      @messages = Message.message_list
      render :index
    end
  end

  # 削除
  def destroy
    @message = Message.find(params[:id])

    # TODO: 削除用パスワードvalidation作成
    if @message.password == params.require(:message)[:password] && @message.destroy!
      flash[:notice] = '削除ok'
      redirect_to :action => :index
    else
      flash[:notice] = '削除ng'
      redirect_to :action => :index
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
        :body,
        :password
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
end
