class Backoffice::GymsController < BackofficeController
  before_action :set_gym, only: [:show, :edit, :update, :destroy]

  #respond_to :js

  def index
    @gym = Gym.new
    @gyms = Gym.all
  end

  def show
  end

  def new
    @gym = Gym.new
    respond_to do |format|
      format.js { @gym }
    end
  end

  def edit
    respond_to do |format|
      format.js { @gym }
    end
  end

  def update
    respond_to do |format|
      if @gym.update_attributes(gym_params)
        flash[:notice] = I18n.t('messages.updated_with', item: @gym.name)
        format.js
      else
        flash[:alert] = I18n.t('messages.updated_errors_with', item: @gym.name)
        format.js
      end
    end
  end

  def create
    @gym = Gym.new(gym_params)

    respond_to do |format|
      if @gym.save
        flash[:notice] = I18n.t('messages.created_with', item: @gym.name)
        format.js
      else
        flash[:alert] = I18n.t('messages.created_errors_with', item: @gym.name)
        format.js
      end
    end
  end

  def destroy
    @gym.destroy

    unless @gym.errors.any?
      redirect_to backoffice_gyms_path, notice: "A academia #{@gym.name} foi deletada com sucesso"
    else
      render :index
    end
  end

  private
    def set_gym
      @gym = Gym.find(params[:id])
    end

    def gym_params
      params.require(:gym).permit(:id, :name)
    end
end
