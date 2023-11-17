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

      # Update an existing alert.
      #
      # @param params [Hash] Query string
      # @return [Hash] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#put-apialertid
      def update_alert(**params)
        put("/api/alert/#{params[:id]}", **params)
      end
    end
  end
end
