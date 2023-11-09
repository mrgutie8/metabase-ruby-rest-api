require 'spec_helper'

RSpec.describe Metabase::Endpoint::Activity do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches Activities' do
      body = [
        {
          'id' => 1,
          'name' => 'Order Dashboard 1',
          'description' => 'Dashboard 1',
          'archived' => false,
          'collection_position' => 1,
          'collection_id' => 1
        },
        {
          'id' => 2,
          'name' => 'Order Dashboard 2',
          'description' => 'Dashboard 2',
          'archived' => false,
          'collection_position' => 2,
          'collection_id' => 2
        }
      ]

      stub_request(:get, "#{host}/api/activity")
        .to_return(status: 200, body: body.to_json)

      begin
        activities_json = client.activities
        activities = JSON.parse(activities_json)

        expect(activities.length).to eq(2)
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/activity")
      end
    end
  end
end
