class Link < ApplicationRecord

  def create
    short_code = SecureRandom.alphanumeric(6)
    @link = Link.new(link_params.merge(short_code: short_code, access_count: 0))

    if @link.save
      render json: @link, status: :created
    else
      render json: @link.errors, status: :unprocessable_entity
    end
  end

end
