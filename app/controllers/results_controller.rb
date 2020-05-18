require 'getresultdatabyproject'
require 'projectreviewrules_params'
class ResultsController < ApplicationController
  before_action :set_result, only: [:show, :edit, :update, :destroy]

  # GET /results
  # GET /results.json
  def index
    begin
    @projects=Project.all.where(:user_id => current_user.id)
    @results = (Projectreviewrules_params::Findresultsfromprojects).find_params(@projects)    
  rescue Exception => e
    puts ("FOund Exception : "+e.to_s)
  end
  end

   def projreview
    projectid     = request.original_url.split('/')[request.original_url.split('/').length - 2]
    tof = request.original_url.split('/')[request.original_url.split('/').length - 1]
    @result_data = (Getresultdatabyproject::GetResultDataByPrj).find_resultdata(projectid,tof)
   end
  # GET /results/1
  # GET /results/1.json
  def show
  end

  # GET /results/new
  def new
    @result = Result.new
  end

  # GET /results/1/edit
  def edit
  end

  # POST /results
  # POST /results.json
  def create
    redirect_to projreview_path(params[:result][:project_id],params[:result][:Type_Of_File])
    # redirect_to projreview(p_id: :project_id, tof: :Type_Of_File)
  end

  # PATCH/PUT /results/1
  # PATCH/PUT /results/1.json
  def update
    respond_to do |format|
      if @result.update(result_params)
        format.html { redirect_to @result, notice: 'Result was successfully updated.' }
        format.json { render :show, status: :ok, location: @result }
      else
        format.html { render :edit }
        format.json { render json: @result.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /results/1
  # DELETE /results/1.json
  def destroy
    @result.destroy
    respond_to do |format|
      format.html { redirect_to results_url, notice: 'Result was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_result
      @result = Result.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def result_params
      params.require(:result).permit(:project_id, :Folder_Name, :Type_Of_File, :FileName, :Error_Line_Number, :Error_Description)
    end
end
