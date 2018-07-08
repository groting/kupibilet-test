class LinksController < ApplicationController

  before_action :abort_if_params_missing
  
  def show
    @link = Link.find_by short_url: params[:short_url]
    if @link.present?
      redirect_to @link.long_url
    else
      render json:{error: "Url not found. Sorry."}, status: :not_found
    end
  end

  def create
    @link = Link.find_or_initialize_by long_url: @long_url
    begin
      @link.save!
      render json:{url: "#{request.host_with_port}/#{@link.short_url}"}, status: :ok
    rescue ActiveRecord::RecordInvalid
      render json:{error: "Url is invalid. Try again."}, status: :unprocessable_entity
    end
  end

  private

  def abort_if_params_missing
    @long_url = params[:longUrl]
    if params[:short_url].blank? && @long_url.nil?
      render(json:{error: "No parametr. Please give short_url or long_url"}, status: :unprocessable_entity) and return
    end
  end
end
