class MessagesController < ApplicationController
  #before_action :set_s 
  helper_method :sort_column, :sort_direction

# 表示 検索
  def index
    # NOTE: 新規投稿フォーム用の変数を作成
    @message = Message.new

    # NOTE: ransackで検索を行う
    @q = Message.ransack(params[:q])

    # NOTE: paramsにソート順が指定されているか確認しなければidの昇順にする
    @q.sorts = 'id asc' if params[:q].try(:[], :s).blank?

    # NOTE: 検索結果を取得し変数に入れる
    @messages = @q.result

    # NOTE: 現在のページ数に合ったレコードを出す(.page(params[:page]))
    # NOTE: paramsに全件表示するとなっていれば全件そうでなければ5件表示
    if params[:all].present?
      @messages = @messages.page(params[:page])
    else
      @messages = @messages.page(params[:page]).per(5)
    end

    # @messages = Message.all
    # #@messages = Message.message_list
    # #@search = Message.ransack(params[:q])
    # #@search.build_sort if @search.sorts.empty?
    # @q = Message.search(params[:q])
    # @messages = @q.result(distinct: true)
    # #@messages = Message.all.order(sort_column + ' ' + sort_direction)
    # #@orders = Message.order(params[:sortway])
    # @messages = Message.page(params[:page])
    # if params[:all].present?
    #    @messages = @messages.page(params[:page])
    # else
    #    @messages = @messages.page(params[:page]).per(5)
    # end
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
