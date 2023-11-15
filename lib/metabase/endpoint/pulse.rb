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

      # Test send an unsaved pulse.
      #
      # @param params [Hash] Query string
      # @return Parsed response JSON
      # @see https://www.metabase.com/docs/latest/api/pulse#post-apipulsetest
      def pulse_test(**params)
        post('/api/pulse/test', **params)
      end

    end
  end
end
