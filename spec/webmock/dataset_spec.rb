require 'spec_helper'

RSpec.describe Metabase::Endpoint::Dataset do
  include_context 'login'

  let(:host) { 'localhost:3030' }
  let(:query) { '{"type":"native","native":{"query":"SELECT * FROM orders LIMIT 1;"},"database":1}' }

  describe 'query_dataset' do
    context 'success' do
      it 'should return query results of the dataset' do
        stub_request(:post, "#{host}/api/dataset/json")
          .with(
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
          )
          .to_return(status: 200, body: 'OK')

        expect(client.query_dataset(query: query)).to eq('OK')
      end

      it 'returns query results of the dataset as specified format' do
        stub_request(:post, "#{host}/api/dataset/csv")
          .with(
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            )
          .to_return(status: 200, body: 'OK')

        expect(client.query_dataset(query: query, format: 'csv')).to eq('OK')
      end
    end
  end
end