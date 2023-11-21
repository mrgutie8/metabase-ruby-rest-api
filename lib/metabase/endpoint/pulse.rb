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

      # Fetch preview card png
      #
      # @param params [Hash] Query string
      # @return [Array<Hash>] Parsed response JSON
      # @see https://www.metabase.com/docs/latest/api/pulse#get-apipulsepreview_card_pngid
      def preview_card_png(**params)
        get("/api/pulse/preview_card_png/#{params[:id]}", **params)
      end
    end
  end
end
