require 'spec_helper'

RSpec.describe Metabase::Endpoint::Dataset do
  include_context 'login'

  let(:host) { 'localhost:3030' }
  let(:query) { '{"type":"native","native":{"query":"SELECT * FROM orders LIMIT 1;"},"database":1}' }

  describe 'query_dataset' do
    context 'success' do
      it 'should return query results of the dataset' do
        stub_request(:get, "#{host}/api/dataset/json", headers: { 'Content-Type': 'application/x-www-form-urlencoded' } )
          .to_return(status: 200, body: 'OK')

        expect(client.query_dataset(query: query)).to have_requested(:post, "#{host}/api/dataset/json")
      end
    end
  end
end