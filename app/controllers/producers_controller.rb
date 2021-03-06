class ProducersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_producer, only: %i[show edit update destroy]

  def new
    @user = current_user
    @producer = @user.build_producer
  end

  def create
    @producer = Producer.new(producer_params)
    @producer.user_id = current_user.id
    @user = current_user
    if @producer.save
      redirect_to user_path(current_user)
    else
      render :new
    end
  end

  def show; end

  def edit
    if @producer.user_id == current_user.id
      @user = current_user
    else
      redirect_to current_user, notice: '権限がありません'
    end
  end

  def update
    if @producer.user_id == current_user.id
      if @producer.update(producer_params)
        redirect_to user_path(current_user)
      else
        render :edit
      end
    else
      redirect_to current_user, notice: '権限がありません'
    end
  end

  def destroy
    if @producer.user_id == current_user.id
      @producer.destroy
      redirect_to user_path(current_user), notice: '生産者情報を削除しました'
    else
      redirect_to current_user, notice: '権限がありません'
    end
  end

  private

  def producer_params
    params.require(:producer).permit(
      :area,
      :pesticide,
      :producer_image,
      :producer_image_cache,
      :content
    )
  end

  def set_producer
    @producer = Producer.find(params[:id])
  end
end
