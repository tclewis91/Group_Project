class TrainersController < ApplicationController
  def index
    render json: Trainer.all
  end


 def show
    render json: Trainer.find(params[:id])
  end

  def new
    render json: Trainer.new
  end

  def create
    begin
      poke_ball = Trainer.create(name: params(:name),message: params(:message),badge: params(:badge))
      render json: poke_ball
    rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end
end


#   # def time
#   #   time.strftime("%B %-d, %Y, %H:%M:%S")
#   # end

