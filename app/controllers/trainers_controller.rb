class TrainersController < ApplicationController
  # def index
  #   render json: Trainer.all
  def time
    Time.now = time.strftime("%B %-d, %Y, %H:%M:%S")
  end

  def index #homepage
    begin
  clear_now = Trainer.all.select { |trainer| trainer.created_at > (Time.now - 300) }
  render json: clear_now
rescue ActionController::RecordNotFound => error
      render json: { error: error.message }, status: 400
    end
  end


 def show #if you need to find a
    render json: Trainer.find(params[:id])
  end

  def create #creates new user
    begin
      poke_ball = Trainer.create(name: params.fetch(:name), message: params.fetch(:message), badge: params.fetch(:badge))
      render json: poke_ball
     rescue ActionController::ParameterMissing => error
      render json: { error: error.message }, status: 422
    end
  end
end

