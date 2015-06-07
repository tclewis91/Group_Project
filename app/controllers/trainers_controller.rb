class TrainersController < ApplicationController

  def index #homepage
    begin
      clear_now = Trainer.all.select { |trainer| trainer.created_at > (Time.now - 300) }
      render json: clear_now
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

  def trainer_search #if you need to find a specific user
    render json: Trainer.where(name: params.fetch(:name))
  end

  def recent_trainers #shows users from past 4 hours
   begin
    time_limit = Trainer.all.select { |trainer| trainer.created_at > (Time.now - 14400) }
    active_trainers = time_limit.group_by { |row| row.name }
                                .sort_by { |key, value| value.count}
                                .map { |row| row.first}
    render json: active_trainers
    rescue ActionController::RecordNotFound => error
      render json: { error: error.message }, status: 400
    end
  end

  def top_trainers# shows top 10 users
    begin
      count_top_trainers = Trainer.all.group_by { |row| row.name }
                                  .sort_by { |key, value| value.count}
                                  .reverse.take(10).map { |row| row.first}
      render json: count_top_trainers
    rescue ActionController::RecordNotFound => error
      render json: { error: error.message }, status: 400
    end
  end

  def top_message_board#shows most used chatrooms
    begin
      count_top_boards = Trainer.all.group_by { |row| row.badge}
                                .sort_by { |key, value| value.count}
                                .reverse.take(151).map { |row| row.first}
      render json: count_top_boards
    rescue ActionController::RecordNotFound => error
      render json: { error: error.message }, status: 400
    end
  end

  def cussing
    @censored_message = params.fetch(:message)
    @censored_message.gsub!(/shit/, 'beep')
    @censored_message.gsub!(/ass/, 'beep')
    @censored_message.gsub!(/bitch\b/, 'beep')
    @censored_message.gsub!(/fuch/, 'beep')
  end

end

