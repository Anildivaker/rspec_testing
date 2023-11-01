class CommentsController < ApplicationController
  before_action :authorize
  before_action :set_comment, only: [:show, :update, :destroy]

  def index
    
    @comments = @user.comments.all
    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params.merge(user: @user))

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.update(comment_params)
      render json: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @comment.destroy
    render json: {message: "Destroy successfully"}, status: :ok
  end

  private
    def set_comment
      @comment = @user.comments.find(params[:id])
      unless @comment.present?
        render json: {message: "not found"}, status: :not_found
      end
    end

    def comment_params
      params.require(:comment).permit(:title, :body)
    end
end
