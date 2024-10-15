class TextpostController < ApplicationController
  def new
    @textpost = Textpost.new
  end

  def create 
    if Current.user.google_account == nil 
      return redirect_to root_path, notice: "Please create a site account and link it to a google account first."
    else
      @textpost = Textpost.create(post_params);
      @textpost.username = Current.user.username;
      if Current.user.textposts << @textpost
        return redirect_to posts_path, notice: "Post created successfully."
      else
        render :new
      end
    end
  end

  def view
    # @posts = Textpost.all
    @posts = Rails.cache.fetch("textposts", expires_in: 12.hours) do
      Textpost.all
    end
    puts Rails.cache.read("textposts") , "THIS IS THE POST CACHE"
  end

  def get
    
  end

  def destroy
    delpost = Textpost.find_by(id: params[:id])  # Find the dog by ID from the parameters

    if delpost
      delpost.destroy
      render :view
    else
      render json: { error: "Post not found." }, status: :not_found
    end
  end

  private
  def post_params
    params.require(:textpost).permit(:post_title, :post_body)
  end

  def del_params
    params.require(:textpost).permit(:id)
  end
end
