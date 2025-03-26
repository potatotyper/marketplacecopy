class TextpostController < ApplicationController
  # skip_before_action :authorized, only: [:getall]

  PPP = 3;
  # def getall
  #   @posts = Textpost.all

  #   render json: @posts
  # end
  
  def new
    @textpost = Textpost.new
  end

  def create
    if Current.user.google_account == nil 
      return redirect_to index_path, notice: "Please create a site account and link it to a google account first."
    else
      @textpost = Textpost.create(post_params);
      @textpost.user_id = Current.user.id;
      if Current.user.textposts << @textpost
        return redirect_to action: 'view', page: 0
      else
        render :new
      end
    end
  end

  def view
    puts Current.user.id
    @page = params.fetch(:page, 0).to_i;
    if @page == 0 
      @posts = Rails.cache.fetch("textposts_page_#{@page}_limit_#{PPP}", expires_in: 12.hours) do
        Textpost.order(created_at: :desc).offset(@page * PPP).limit(PPP);
      end
    else
      @posts = Textpost.order(created_at: :desc).offset(@page * PPP).limit(PPP);
    end
  end

  def item
    @item = Textpost.find_by(id: params[:id])
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
