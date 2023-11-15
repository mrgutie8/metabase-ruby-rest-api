# frozen_string_literal: true

module Metabase
  module Endpoint
    module Alert
      # Fetch all alerts.
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api-documentation.md#get-apialert
      def alerts(**params)
        get('/api/alert', **params)
      end

      # Fetch all questions for the given question(card) id.
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#get-apialertquestionid
      def questions(**params)
        get("/api/alert/question/#{params[:id]}", **params)
      end
    end
  end
end
