require 'rails_helper'

describe Answer do
  before(:each) do
    Question.delete_all
    Answer.delete_all
  end

  it "is connected to a question" do
    expect(Answer.new(answer: "test answer")).to_not be_valid
  end

  it "is added to the database when created" do
    count = Answer.all.count
    question = Question.create(question: "test question")
    Answer.create(answer: "test answer", question_id: question.id)
    expect(Answer.all.count).not_to eq(count)
  end

  it "is changed in the database when updated"
  it "is removed from the databse when deleted"
end
