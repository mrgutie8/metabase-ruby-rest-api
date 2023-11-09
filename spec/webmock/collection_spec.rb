require 'spec_helper'

RSpec.describe Metabase::Endpoint::Collection do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches Collections' do
      body = [
        {
          'id' => 1,
          'name' => 'Collection 1',
          'color' => '#FFFFFF',
          'description' => 'Collection 1 Description',
          'parent_id' => 1,
          'namespace' => 'Collection 1 Name Space',
          'authority_level' => 'official'
        },
        {
          'id' => 2,
          'name' => 'Collection 2',
          'color' => '#AAAAAA',
          'description' => 'Collection 2 Description',
          'parent_id' => 2,
          'namespace' => 'Collection 2 Name Space',
          'authority_level' => 'official'
        }
      ]

      stub_request(:get, "#{host}/api/collection")
        .to_return(status: 200, body: body.to_json)

      begin
        collections_json = client.collections
        collections = JSON.parse(collections_json)

        expect(collections.length).to eq(2)
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/collection")
      end
    end
  end
end
