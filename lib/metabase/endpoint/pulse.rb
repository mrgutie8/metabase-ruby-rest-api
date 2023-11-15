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

      # Fetch HTML rendering of a Card with id.
      #
      # @param params [Hash] Query string
      # @return [Hash] Parsed response JSON
      # @see https://github.com/metabase/metabase/blob/master/docs/api/pulse.md#get-apipulsepreview_cardid
      def pulse_preview_card(**params)
        get("/api/pulse/preview_card/#{params[:id]}", **params)
      end
    end
  end
end
