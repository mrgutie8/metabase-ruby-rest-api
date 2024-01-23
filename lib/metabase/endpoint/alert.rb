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

      # Update an existing alert.
      #
      # @param params [Hash] Query string
      # @return [Hash] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#put-apialertid
      def update_alert(**params)
        put("/api/alert/#{params[:id]}", **params)

      end
      # Create a new alert
      #
      # @param params [Hash] Query string
      # @return [Hash] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#post-apialert
      def create_alert(**params)
        post('/api/alert', **params)
      end

      # Fetch all questions for the given question(card) id.
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#get-apialertquestionid
      def questions(**params)
        get("/api/alert/question/#{params[:id]}", **params)
      end
      
      # Fetch a Alert.
      #
      # @param params [Hash] Query string
      # @return [Hash] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/alert.md#get-apialertid
      def alert(**params)
        get("/api/alert/#{params[:id]}", **params)
      end
    end
  end
end
