class TrainersController < ApplicationController
  # def index
  #   render json: Trainer.all
  def time
    time.now = time.strftime("%B %-d, %Y, %H:%M:%S")
  end



  def index #homepage
   render json: Trainer.all.select{ |trainer| trainer.created_at > (time.now - 300) }
    # render json: Trainer.clear_board

    # .order(created_at: :dsc)
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


#figure out if need to cretate a new method for chat rooms

end


