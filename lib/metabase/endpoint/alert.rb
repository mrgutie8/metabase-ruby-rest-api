# frozen_string_literal: true

module Metabase
  module Endpoint
    module Alert
      # Unsubscribe from the given alert
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#delete-apialertidsubscription
      def delete_alert_subscription(**params)
        delete("/api/alert/#{params[:id]}/subscription", **params)
      end

      # Fetch all alerts.
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api-documentation.md#get-apialert
      def alerts(**params)
        get('/api/alert', **params)
      end
    end
  end
end
