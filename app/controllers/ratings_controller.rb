class RatingsController < ApplicationController
  def index
    @ratings = Rating.all
    @users = User.all
  end

  def new
    @rating = Rating.new
    @beers = Beer.all
  end


  def create
    @rating = Rating.new params.require(:rating).permit(:score, :beer_id)
    if (current_user.nil?)
      redirect_to signin_path, notice: "You must be logged in to rate"
      else
        if (@rating.save)
          current_user.ratings << @rating
          redirect_to ratings_path
        else
          @beers = Beer.all
          render :new
        end
    end
  end

  def destroy
    rating = Rating.find(params[:id])
    rating.delete if current_user == rating.user
    redirect_to :back
  end

end