require 'spec_helper'

RSpec.describe Metabase::Endpoint::Metric do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  describe 'metrics' do
    context 'success' do
      it 'should return all metrics' do
        stub_request(:get, "#{host}/api/metric")
          .to_return(status: 200, body: 'OK')

        begin
          expect(client.metrics).to eq('OK')
        rescue StandardError
          expect(WebMock).to have_requested(:put, "#{host}/api/metric")
        end
      end
    end
  end
end