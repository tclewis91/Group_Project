class TrainersController < ApplicationController
  def index
    render json: Trainer.all



  #     def index #homepage
  #   clear_board = Trainer.all.select{ |trainer| (time.now - 300)}
  #   render json: Trainer.where(created_at: clear_board).order(created_at: :desc)
  # rescue ActionController::RecordNotFound => error, status: 400
  #     render json: { error: error.message }
  #   end
  # end
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

   def time
    time.now = time.strftime("%B %-d, %Y, %H:%M:%S")
  end

#figure out if need to cretate a new method for chat rooms

end


