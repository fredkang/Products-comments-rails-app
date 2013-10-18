class CommentsController < ApplicationController
  def create
  	# comment_params['product_id'] = params['product_id']
  	@comment = Comment.new(comment_params)

  	if @comment.save
  		redirect_to "/products/"+@comment.product_id.to_s, notice: "Comment succesfully added"
  	else
  		redirect_to "/products/"+@comment.product_id.to_s, notice: "Could not add comment"
  	end
  end

  def index
  	@comments = Comment.all
  end

  def show
  end

  private
  def comment_params
    params.require(:comment).permit(:author, :content, :product_id)
  end
end
