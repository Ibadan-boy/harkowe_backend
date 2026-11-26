class WritingsController < ApplicationController

  def create
    writing = Current.user.writings.create!(
      title: params[:title],
      content: params[:content]
    )

    render json: {
      message: "Writing successfully created!",
      writing: writing
    }, status: :created
  end

  def index
    writings = Current.user.writings

    render json: writings
  end

  def show
    writing = Current.user.writings.find_by!(
      document_id: params[:id]
    )

    render json: writing
  end

  def destroy
    writing = Current.user.writings.find_by!(
      document_id: params[:id]
    )
    writing.destroy!

    render json: {
        message: "Writing successfully deleted!"
    }
  end

  def update
        writing = Current.user.writings.find_by!(
            document_id: params[:id]
        )

        writing_data = params.require(:writingData)

        attributes = writing_data.permit(
            :title,
            content: {}
        )

        if attributes.empty?
            return render json: {
            error: "No attributes provided for update"
            }, status: :unprocessable_entity
        end

        if writing.update(attributes)
            render json: {
            message: "Writing updated successfully",
            writing: writing
            }, status: :ok
        else
            render json: {
            errors: writing.errors.full_messages
            }, status: :unprocessable_entity
        end
    end
end
