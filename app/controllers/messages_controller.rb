class MessagesController < ApplicationController


  # NOTE: 表示 検索
  def index
    @message = Message.new

    @q, @messages = search
  end

  # NOTE: 書き込み
  def create
    @message = Message.new(message_params)

    if @message.save
      return redirect_to action: :index
    else
      @q, @messages = search

      return render :index
    end
  end

  # 削除
  def destroy
    @message = Message.find(params[:id])

    if @message.check_destroy_password(params[:message][:password])
      flash[:notice] = '削除ok'
      return redirect_to :action => :index
    else
      flash[:notice] = '削除ng'
      @q, @messages = search
      return render :action => :index
    end
  end

  private

  def message_params
    params.require(:message)
      .permit(
        :name,
        :body,
        :password
      )
  end

  def search
    q = Message.search(params[:q])
    q.sorts = 'created_at asc' if q.sorts.blank?

    messages = q.result

    if params[:all].blank?
      messages = messages.page(params[:page]).per(5)
    end

    return q, messages
  end
end
