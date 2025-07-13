class LinksController < ApplicationController

  def create
    short_code = SecureRandom.alphanumeric(6)
    @link = Link.new(link_params.merge(short_code: short_code, access_count: 0))

    if @link.save
      render json: @link, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end


  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def set_link
    @link = Link.find_by!(short_code: params[:short_code])
    rescue ActiveRecord::RecordNotFound
    render json: { error: "Short URL not found" }, status: :not_found
  end

end
