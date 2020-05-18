class ReviewsController < ApplicationController
  def index
  	@reviews = Review.all
  end

  def new
	@review = Review.new
  end

  def edit
@review = Review.find(params[:id])
  end

  def update
  	@review = Review.find(params[:id])
     respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end 
  end

  def destroy
  	@review = Review.find(params[:id])
    @review.destroy
        respond_to do |format|
      format.html { redirect_to reviews_url, notice: 'Review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create
  	    @review = Review.new(review_params)

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  	@review = Review.find(params[:id])
  end

      def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:FileType, :ReviewName, :ReviewValue)
    end

end
