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

      # Create a new alert
      #
      # @param params [Hash] Query string
      # @return [Hash] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#post-apialert
      def create_alert(**params)
        post('/api/alert', **params)
      end
    end
  end
end
