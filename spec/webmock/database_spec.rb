require 'spec_helper'

RSpec.describe Metabase::Endpoint::Database do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches Databases' do

      stub_request(:get, "#{host}/api/database")
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.databases).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/database")
      end
    end
  end
end
