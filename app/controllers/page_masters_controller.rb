class PageMastersController < ApplicationController
  before_action :set_page_master, only: [:show, :edit, :update, :destroy]

  # GET /page_masters
  # GET /page_masters.json
  def index
    @page_masters = PageMaster.all
  end

  # GET /page_masters/1
  # GET /page_masters/1.json
  def show
  end

  # GET /page_masters/new
  def new
    @page_master = PageMaster.new
  end

  # GET /page_masters/1/edit
  def edit
  end

  # POST /page_masters
  # POST /page_masters.json
  def create
    @page_master = PageMaster.new(page_master_params)

    respond_to do |format|
      if @page_master.save
        format.html { redirect_to @page_master, notice: 'Page master was successfully created.' }
        format.json { render :show, status: :created, location: @page_master }
      else
        format.html { render :new }
        format.json { render json: @page_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /page_masters/1
  # PATCH/PUT /page_masters/1.json
  def update
    respond_to do |format|
      if @page_master.update(page_master_params)
        format.html { redirect_to @page_master, notice: 'Page master was successfully updated.' }
        format.json { render :show, status: :ok, location: @page_master }
      else
        format.html { render :edit }
        format.json { render json: @page_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /page_masters/1
  # DELETE /page_masters/1.json
  def destroy
    @page_master.destroy
    respond_to do |format|
      format.html { redirect_to page_masters_url, notice: 'Page master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page_master
      @page_master = PageMaster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def page_master_params
      params.require(:page_master).permit(:pagename, :pagelink)
    end
end
