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
    end
  end
end
