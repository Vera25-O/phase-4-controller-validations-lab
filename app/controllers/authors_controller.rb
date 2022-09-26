class AuthorsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
  # added rescue_from
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

  def show
    author = Author.find(params[:id])

    render json: author
  end

  def create
    author = Author.create!(author_params)
  render json: author, status: :created
  end

  def update
    author = find_author
    # update! exceptions will be handled by the rescue_from ActiveRecord::RecordInvalid code
    author.update!(author_params)
    render json: author
  end

  private

  def render_unprocessable_entity_response(invalid)
    render json: { errors: invalid.record.errors}, status: :unprocessable_entity
  end
  
  def author_params
    params.permit(:email, :name)
  end
  


end
