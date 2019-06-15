module Concerns
  module ErrorHandler
    extend ActiveSupport::Concern

    included do
      rescue_from ActiveRecord::RecordNotFound, with: :not_found
    end

    # def render_error(message, status)
    #   message.class != Array ? (message = [message]) : nil
    #   render json: {errors: message}, status: status
    # end

    # def not_found
    #   render_error(I18n.t('errors.messages.not_found'), :not_found)
    # end

    def respond_with_error(message, status = 500, errors = {}, error_code = nil, response_body = {})
      response_body[:message] = message
      response_body[:error_code] = error_code unless error_code.nil?
      response_body[:errors] = errors if errors.present?
      flash[:notice] = response_body
      # render json: response_body, status: status
    end
  end
end
