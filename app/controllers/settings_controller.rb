class SettingsController < ApplicationController
	before_action :logged_in_user

  def index
		@settings = Setting.first
  end

	def update
		@settings = Setting.first
		@settings.includeLastYear = params[:settings][:includeLastYear] == '1'
		@settings.save
		redirect_to root_url
	end
end
