class MessagesController < ApplicationController

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
  end

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
    redirect_to messages_path
    #@posting.errors.messages
  end

  private

  def message_params
    params.require(:message).permit(
        :title,
        :deletepwd,
        :body
    )
  end
end
