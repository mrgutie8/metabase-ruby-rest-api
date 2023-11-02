# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Public do
  include_context 'login'

  let(:host) { 'localhost:3030' }
  let(:card_uuid) { '708a78ec-15c8-405e-b590-de98c6ddfa01' }

  context 'success' do
    it 'fetches public card request' do

      stub_request(:get, "#{host}/api/public/card/#{card_uuid}")
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.public_card(card_uuid)).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/public/card/#{card_uuid}")
      end
    end

    it 'fetches query_public_card_with_metadata' do

      stub_request(:get, "#{host}/api/public/card/#{card_uuid}/query")
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.query_public_card_with_metadata(card_uuid)).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/public/card/#{card_uuid}/query")
      end
    end
  end
end