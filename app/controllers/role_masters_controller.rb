class RoleMastersController < ApplicationController
  before_action :set_role_master, only: [:show, :edit, :update, :destroy]

  # GET /role_masters
  # GET /role_masters.json
  def index
    @role_masters = RoleMaster.all
  end

  # GET /role_masters/1
  # GET /role_masters/1.json
  def show
  end

  # GET /role_masters/new
  def new
    @role_master = RoleMaster.new
  end

  # GET /role_masters/1/edit
  def edit
  end

  # POST /role_masters
  # POST /role_masters.json
  def create
    @role_master = RoleMaster.new(role_master_params)

    respond_to do |format|
      if @role_master.save
        format.html { redirect_to @role_master, notice: 'Role master was successfully created.' }
        format.json { render :show, status: :created, location: @role_master }
      else
        format.html { render :new }
        format.json { render json: @role_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /role_masters/1
  # PATCH/PUT /role_masters/1.json
  def update
    respond_to do |format|
      if @role_master.update(role_master_params)
        format.html { redirect_to @role_master, notice: 'Role master was successfully updated.' }
        format.json { render :show, status: :ok, location: @role_master }
      else
        format.html { render :edit }
        format.json { render json: @role_master.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /role_masters/1
  # DELETE /role_masters/1.json
  def destroy
    @role_master.destroy
    respond_to do |format|
      format.html { redirect_to role_masters_url, notice: 'Role master was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role_master
      @role_master = RoleMaster.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def role_master_params
      params.require(:role_master).permit(:rolename)
    end
end
