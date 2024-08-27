class TextpostController < ApplicationController
  def new
    @textpost = Textpost.new
  end

  def create 
    if Current.user.google_account == nil 
      return redirect_to root_path, notice: "Please create a site account and link it to a google account first."
    else
      @textpost = Textpost.create(post_params);
      if Current.user.textposts << @textpost
        return redirect_to posts_path, notice: "Post created successfully."
      else
        render :new
      end
    end
  end

  def view
    @posts = Textpost.all
  end

  private
  def post_params
    params.require(:textpost).permit(:post_title, :post_body)
  end
end
