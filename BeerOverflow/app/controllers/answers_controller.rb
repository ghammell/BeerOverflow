class AnswersController < ActionController::Base

  def index
    @question = Question.find(params[:id])
  end

  def create
    session[:return_to] ||= request.referer
    @answer = Question.find(params[:question_id]).answers.new(answer_params)
    if @answer.save
      flash[:notice] = "Thanks for posting!"
    else
      flash[:alert] = "You must be logged in to use that function."
    end
    redirect_to session.delete(:return_to)
  end

  def new
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def upvote
    @answer = Answer.find(params[:id])
    @answer.votes.create(value: 1)
    redirect_to @answer.question
  end

  def downvote
    @answer = Answer.find(params[:id])
    @answer.votes.create(value: -1)
    redirect_to @answer.question
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update_attributes(answer_params)
    redirect_to '/'
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to '/'
  end

  private

  def answer_params
    params.require(:answer).permit(:answer)
  end

end
