# frozen_string_literal: true

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
    it 'Unsubscribes user from alert subscription' do
      stub_request(:delete, 'http://localhost:3030/api/alert/1/subscription?id=1')
        .with(
          headers: {
            'Accept' => '*/*',
            'Accept-Encoding' => 'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
            'User-Agent' => 'MetabaseRuby/0.5.0 (ruby3.0.2)',
            'X-Metabase-Session' => 'bca8d83e-7d37-4670-81b6-560ac452773e'
          }
        )
        .to_return(status: 200, body: 'OK', headers: {})

      begin
        alert_json = client.delete_alert_subscription(id: 1)
        expect(alert_json).to eq('OK')
      rescue StandardError
        expect(WebMock).to have_requested(:delete, "#{host}/api/alert/1/subscription")
      end
    end
  end
end
