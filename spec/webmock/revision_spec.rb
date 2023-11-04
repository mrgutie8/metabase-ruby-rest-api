# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Revision do
  include_context 'login'

  let(:host) { 'localhost:3030' }
  let(:entityType) { 'card' }
  let(:entityId) { '1' }

  context 'success' do
    it 'fetches all segments' do

      stub_request(:get, "#{host}/api/revision")
        .with(body: {entity: "#{entityType}", id: "#{entityId}"})
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.revisions).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/revision}")
      end
    end
  end
end