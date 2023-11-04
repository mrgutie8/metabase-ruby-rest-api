# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Table do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'fetches all tables' do

      stub_request(:get, "#{host}/api/table")
        .to_return(status: 200, body: 'OK')

      begin
        expect(client.tables).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/table}")
      end
    end
  end
end