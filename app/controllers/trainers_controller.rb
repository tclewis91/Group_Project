class TrainersController < ApplicationController
   def time#format time
    time.now = time.strftime("%B %-d, %Y, %H:%M:%S")
  end

  def index #homepage
    clear_board = Trainer.all.select{ |trainer| (time.now - 300) }
    render json: Trainer.where(created_at: clear_board).order(created_at: :desc)
  rescue ActionController::RecordNotFound => error, status: 400
      render json: { error: error.message }
    end
  end

 def show #if you need to find a user
    render json: Trainer.find(params[:id])
  rescue ActionController::RecordNotFound => error
      render json: { error: error.message }, status: 400
    end
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


