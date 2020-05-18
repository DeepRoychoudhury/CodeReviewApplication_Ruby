class RolePagesController < ApplicationController
  before_action :set_role_page, only: [:show, :edit, :update, :destroy]

  # GET /role_pages
  # GET /role_pages.json
  def index
    @role_pages = RolePage.all
  end

  # GET /role_pages/1
  # GET /role_pages/1.json
  def show
  end

  # GET /role_pages/new
  def new
    @role_page = RolePage.new
  end

  # GET /role_pages/1/edit
  def edit
  end

  # POST /role_pages
  # POST /role_pages.json
  def create
    @role_page = RolePage.new(role_page_params)

    respond_to do |format|
      if @role_page.save
        format.html { redirect_to @role_page, notice: 'Role page was successfully created.' }
        format.json { render :show, status: :created, location: @role_page }
      else
        format.html { render :new }
        format.json { render json: @role_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_pages/1
  # PATCH/PUT /role_pages/1.json
  def update
    respond_to do |format|
      if @role_page.update(role_page_params)
        format.html { redirect_to @role_page, notice: 'Role page was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_page }
      else
        format.html { render :edit }
        format.json { render json: @role_page.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_pages/1
  # DELETE /role_pages/1.json
  def destroy
    @role_page.destroy
    respond_to do |format|
      format.html { redirect_to role_pages_url, notice: 'Role page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_page
      @role_page = RolePage.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_page_params
      params.require(:role_page).permit(:role_master_id, :page_master_id)
    end
end
