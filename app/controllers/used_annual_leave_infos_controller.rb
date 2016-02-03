class UsedAnnualLeaveInfosController < ApplicationController
  before_action :set_used_annual_leave_info, only: [:show, :edit, :update, :destroy]

  # GET /used_annual_leave_infos
  # GET /used_annual_leave_infos.json
  def index
    @used_annual_leave_infos = UsedAnnualLeaveInfo.all
  end

  # GET /used_annual_leave_infos/1
  # GET /used_annual_leave_infos/1.json
  def show
  end

  # GET /used_annual_leave_infos/new
  def new
    @used_annual_leave_info = UsedAnnualLeaveInfo.new
  end

  # GET /used_annual_leave_infos/1/edit
  def edit
  end

  # POST /used_annual_leave_infos
  # POST /used_annual_leave_infos.json
  def create
    @used_annual_leave_info = UsedAnnualLeaveInfo.new(used_annual_leave_info_params)

    respond_to do |format|
      if @used_annual_leave_info.save
        format.html { redirect_to @used_annual_leave_info, notice: 'Used annual leave info was successfully created.' }
        format.json { render :show, status: :created, location: @used_annual_leave_info }
      else
        format.html { render :new }
        format.json { render json: @used_annual_leave_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /used_annual_leave_infos/1
  # PATCH/PUT /used_annual_leave_infos/1.json
  def update
    respond_to do |format|
      if @used_annual_leave_info.update(used_annual_leave_info_params)
        format.html { redirect_to @used_annual_leave_info, notice: 'Used annual leave info was successfully updated.' }
        format.json { render :show, status: :ok, location: @used_annual_leave_info }
      else
        format.html { render :edit }
        format.json { render json: @used_annual_leave_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /used_annual_leave_infos/1
  # DELETE /used_annual_leave_infos/1.json
  def destroy
    @used_annual_leave_info.destroy
    respond_to do |format|
      format.html { redirect_to used_annual_leave_infos_url, notice: 'Used annual leave info was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_used_annual_leave_info
      @used_annual_leave_info = UsedAnnualLeaveInfo.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def used_annual_leave_info_params
      params.require(:used_annual_leave_info).permit(:when, :number, :whichyear, :employee_id)
    end
end
