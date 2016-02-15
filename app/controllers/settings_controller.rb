class SettingsController < ApplicationController
	before_action :logged_in_user

  def index
		@settings = Setting.first
  end

	def update
		@settings = Setting.first
		@settings.includeLastYear = params[:settings][:includeLastYear] == '1'
		if @settings.save
			flash[:success] = "设置保存成功"
			redirect_to root_url
		else
			flash.now[:warning] = "设置保存失败"
			render :index
		end
	end
end
