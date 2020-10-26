class UrlsController < ApplicationController
  protect_from_forgery with: :null_session

  def show
    url = Url.find_by(slug: params[:slug])
    return render(json: { errors: 'Url not found' }, status: 404) if url.blank?

    url.increment!(:hits)
    render(json: url.original_url.to_json, status: 200)
  end

  def create
    url = Url.find_or_create_by(original_url: params[:original_url])
    return render(json: url.short.to_json, status: 200) if url.valid?
    render(json: { errors: 'Invalid parameters' }, status: 400)
  end

  def stats
    url = Url.find_by(slug: params[:slug])
    return render(json: {errors: 'Url not found'}, status: 404) if url.blank?

    render(json: url.hits, status: 200)
  end
end
