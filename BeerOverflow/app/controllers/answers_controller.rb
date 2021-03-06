class AnswersController < ActionController::Base

  def index
    @question = Question.find(params[:id])
  end

  def create
    session[:return_to] ||= request.referer
    @question = Question.find(params[:question_id])
    @answer = @question.answers.new(answer_params)
    @comment = Comment.new
    if @answer.save
      flash[:notice] = "Thanks for posting!"
    else
      flash[:alert] = "You must be logged in to use that function."
    end
    render partial: 'answers/displayanswers', locals: {question: @question, answer: @answer, comment: @comment}
  end

  def new
    @question = Question.find(params[:id])
    @answer = Answer.new
  end

  def upvote
    @answer = Answer.find(params[:id])  
    @vote = @answer.votes.new(value: 1, user_id: session[:user_id])
    if @vote.save
      render :partial => 'votes/success'
    else
      render :partial => 'votes/failure'
    end    
  end

  def downvote
    @answer = Answer.find(params[:id])
    @vote = @answer.votes.new(value: -1, user_id: session[:user_id])
    if @vote.save
      render :partial => 'votes/success'
    else
      render :partial => 'votes/failure'
    end   
  end

  def best
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
    @answer.update_attributes(best: true)
    @question.update_attributes(has_best_answer: true)
    redirect_to @answer.question
  end

  def edit
    @question = Question.find(params[:question_id])
    @answer = Answer.find(params[:id])
  end

  def update
    @answer = Answer.find(params[:id])
    @answer.update_attributes(answer_params)
    redirect_to @answer.question
  end

  def destroy
    @answer = Answer.find(params[:id])
    @answer.destroy
    redirect_to @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:answer, :user_id)
  end

end
