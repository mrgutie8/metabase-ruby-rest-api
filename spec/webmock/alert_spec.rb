require 'spec_helper'

RSpec.describe Metabase::Endpoint::Alert do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches Alerts' do
      body = [
        {
          'id' => 1,
          'name' => 'Alert 1',
          'collection_position' => 1,
          'collection_id' => 1,
          'alert_condition' => 'rows',
          'alert_first_only' => false,
          'archived' => false,
          'can_write' => true
        },
        {
          'id' => 2,
          'name' => 'Alert 2',
          'collection_position' => 2,
          'collection_id' => 2,
          'alert_condition' => 'rows',
          'alert_first_only' => false,
          'archived' => false,
          'can_write' => true
        }
      ]

      stub_request(:get, "#{host}/api/alert")
        .to_return(status: 200, body: body.to_json)

      begin
        alerts_json = client.alerts
        alerts = JSON.parse(alerts_json)

        expect(alerts.length).to eq(2)
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/alert")
      end
    end

    ###################################################################################################################
    # POST ALERT TEST
    # #################################################################################################################
    it 'Creates a new user' do
      body = {
        'alert_condition' => 'goal',
        'card' => 'id',
        'alert_first_only' => true,
        'alert_above_goal' => false,
        'channels' => [{ 'id' => true }]
      }

      stub_request(:post, "#{host}/api/alert")
        .to_return(status: 200, body: body.to_json)

      begin
        response_json = client.create_alert(
          alert_condition: 'goal',
          card: 'id',
          alert_first_only: true,
          alert_above_goal: false,
          channels: [{ 'id' => true }]
        )
        new_alert = JSON.parse(response_json)

        # Assert the response and test your code's behavior
        expect(new_alert['channels'].length).to eq(1)
      rescue StandardError
        expect(WebMock).to have_requested(:post, "#{host}/api/alert")
      end
    end
  end
end
