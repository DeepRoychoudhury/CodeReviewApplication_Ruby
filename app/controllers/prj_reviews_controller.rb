require 'projectreviewrules_params'
class PrjReviewsController < ApplicationController
  before_action :set_prj_review, only: [:show, :edit, :update, :destroy]

  # GET /prj_reviews
  # GET /prj_reviews.json
  def self.findparams(data, typeofdata)
    typeofdata.find_params(data)
  end

  def index
    begin
    @user=User.find(current_user.id)
    @prj_reviews=PrjReviewsController.findparams(@user, Projectreviewrules_params::Findprojreviewsfromuser)  
    rescue Exception => e
    puts ("Fuund Exception : "+e.to_s)
    end
  end

  # GET /prj_reviews/1
  # GET /prj_reviews/1.json
  def show
  end

  # GET /prj_reviews/new
  def new
    @prj_review = PrjReview.new
  end

  # GET /prj_reviews/1/edit
  def edit
    @prj_review=PrjReview.find(params[:id])
  end

  # POST /prj_reviews
  # POST /prj_reviews.json
  def create
    @prj_review = PrjReview.new(prj_review_params)

    respond_to do |format|
      if @prj_review.save
        format.html { redirect_to @prj_review, notice: 'Prj review was successfully created.' }
        format.json { render :show, status: :created, location: @prj_review }
      else
        format.html { render :new }
        format.json { render json: @prj_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /prj_reviews/1
  # PATCH/PUT /prj_reviews/1.json
  def update
    respond_to do |format|
      if @prj_review.update(prj_review_params)
        format.html { redirect_to @prj_review, notice: 'Prj review was successfully updated.' }
        format.json { render :show, status: :ok, location: @prj_review }
      else
        format.html { render :edit }
        format.json { render json: @prj_review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /prj_reviews/1
  # DELETE /prj_reviews/1.json
  def destroy
    @prj_review.destroy
    respond_to do |format|
      format.html { redirect_to prj_reviews_url, notice: 'Prj review was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prj_review
      @prj_review = PrjReview.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def prj_review_params
      params.require(:prj_review).permit(:project_id, :review_id, :reviewtype, :reviewvalue)
    end
end
