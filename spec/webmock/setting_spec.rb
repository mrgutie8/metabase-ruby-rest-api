# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Setting do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'fetches all settings' do

      stub_request(:get, "#{host}/api/setting")
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.settings).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/setting}")
      end
    end
  end
end