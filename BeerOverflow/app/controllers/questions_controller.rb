class QuestionsController < ApplicationController

  def index
    @questions = Question.order(created_at: :desc)
    @question_yes = Question.last
    @question = Question.new
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers
    @answer = Answer.new
    @vote = Vote.new
    @comment = Comment.new
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    if @question.save
      flash[:notice] = "Thanks for posting!"
    else
      flash[:alert] = "You must be logged in to use that function."
    end
    render partial: 'question', locals: {question: @question}
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    @question.update_attributes(question_params)
    redirect_to @question
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to root_path
  end


  def upvote
    @question = Question.find(params[:id])
    @vote = @question.votes.new(value: 1, user_id: session[:user_id])
    if @vote.save
      render :partial => 'votes/success'
    else
      render :partial => 'votes/failure'
    end      
  end

  def downvote
    @question = Question.find(params[:id])
    @vote = @question.votes.new(value: -1, user_id: session[:user_id])
    if @vote.save
      render :partial => 'votes/success'
    else
      render :partial => 'votes/failure'
    end 
  end

  private
  def question_params
    params.require(:question).permit(:question, :user_id)
  end
end
