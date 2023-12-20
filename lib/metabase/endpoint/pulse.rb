# frozen_string_literal: true

module Metabase
  module Endpoint
    module Pulse
      # Fetch all pulses.
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api-documentation.md#get-apipulse
      def pulses(**params)
        get('/api/pulse', **params)
      end

      # Get form input
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://www.metabase.com/docs/latest/api/pulse#get-apipulseform_input
      def form_input(**params)
        get('/api/pulse/form_input', **params)
      end
      
      # Delete a subscription.
      #
      # @param params [Hash] Query string
      # @return Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/pulse.md#delete-apipulseidsubscription
      def delete_subscription(**params)
        delete("/api/pulse/#{params[:id]}/subscription", **params)
      end

      # Test send an unsaved pulse.
      #
      # @param params [Hash] Query string
      # @return Parsed response JSON
      # @see https://www.metabase.com/docs/latest/api/pulse#post-apipulsetest
      def pulse_test(**params)
        post('/api/pulse/test', **params)
      end

      # Update a pulse with id.
      #
      # @param params [Hash] Query string
      # @return Parsed response JSON
      # @see https://www.metabase.com/docs/latest/api/pulse#put-apipulseid
      def update_pulse(**params)
        put("/api/pulse/#{params[:id]}", **params)
      end

    end
  end
end
