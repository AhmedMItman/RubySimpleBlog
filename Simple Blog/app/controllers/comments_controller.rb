class CommentsController < ApplicationController

  before_action :set_post, :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
  end

  # GET /comments/new
  def new
    @comment = Comment.new

  end

  # GET /comments/1/edit
  def edit

  end

  # POST /comments
  # POST /comments.json
  def create
    @post=Post.find(params[:post_id])
    @comment = @post.comments.create(comment_params)
    if current_user
      @comment.user_id=current_user.id
      @comment.user_userName=current_user.userName
    else
      @comment.user_id=nil
    end
    respond_to do |format|
      if @comment.save
        #redirect_to post_path(@post)
         format.html { redirect_to post_path(@post), notice: 'Comment was successfully created.' }
         format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json

  def destroy
    @post = Post.find(params[:post_id])

    # respond_to do |format|
    #   format.html { redirect_to post_path(@post), notice: 'Comment was successfully destroyed.' }
    #   format.json { head :no_content }
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
    end

  private

    def set_post
      @post=Post.find(params[:post_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = @post.comments.find(params[:id])

    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:body, :user_id, :user_userName, :post_id)
    end
end