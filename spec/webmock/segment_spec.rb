# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Segment do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'fetches all segments' do

      stub_request(:get, "#{host}/api/segment")
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.segment).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/segment}")
      end
    end
  end
end