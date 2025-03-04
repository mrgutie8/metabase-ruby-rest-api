# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Pulse do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches all dashboard subscriptions' do
      stub_request(:get, "#{host}/api/pulse")
        .to_return(status: 200, body:
          '[
          {
              "archived": false,
              "collection_position": null,
              "creator": {
                  "email": "mb@example.com",
                  "first_name": "Admin",
                  "last_login": "2023-10-26T23:56:04.102",
                  "is_qbnewb": false,
                  "is_superuser": true,
                  "id": 1,
                  "last_name": "User",
                  "date_joined": "2020-06-07T05:20:41.859",
                  "common_name": "Admin User"
              },
              "can_write": true,
              "channels": [
                  {
                      "schedule_type": "daily",
                      "schedule_hour": 8,
                      "channel_type": "email",
                      "schedule_frame": null,
                      "recipients": [],
                      "updated_at": "2020-06-07T06:16:40.511",
                      "pulse_id": 1,
                      "id": 1,
                      "schedule_day": null,
                      "enabled": false,
                      "created_at": "2020-06-07T06:01:07.784"
                  },
                  {
                      "schedule_type": "monthly",
                      "schedule_hour": 18,
                      "channel_type": "slack",
                      "schedule_frame": "first",
                      "recipients": [],
                      "updated_at": "2020-06-07T06:16:40.511",
                      "details": {
                          "channel": "#metabase-test"
                      },
                      "pulse_id": 1,
                      "id": 2,
                      "schedule_day": "mon",
                      "enabled": true,
                      "created_at": "2020-06-07T06:16:40.511"
                  }
              ],
              "collection_id": 5,
              "name": "Pulse: Average quantity per month",
              "creator_id": 1,
              "updated_at": "2020-06-07T06:16:40.511",
              "id": 1,
              "cards": [
                  {
                      "id": 18,
                      "name": "Average quantity per month",
                      "description": "Average item quantity per month",
                      "collection_id": 5,
                      "display": "line",
                      "include_csv": false,
                      "include_xls": false
                  }
              ],
              "skip_if_empty": false,
              "created_at": "2020-06-07T06:01:07.784"
          }
      ]')

      pulse_json = client.pulses
      pulses = JSON.parse(pulse_json)

      expect(pulses).to be_kind_of(Array)
    end

    it 'Fetches Pulse with ID' do
      stub_request(:get, 'http://localhost:3030/api/pulse/1')
        .to_return(status: 200, body: '', headers: {})

      begin
        pulse_1_json = client.pulse(id: 1)
        pulse = JSON.parse(pulse_1_json)

        expect(pulse).to be_kind_of(Hash)
      rescue StandardError
        expect(WebMock).to have_requested(:get, 'http://localhost:3030/api/pulse/1')
      end
    end

    it 'fetches HTML Rendering of a Card with id' do
      stub_request(:get, "http://localhost:3030/api/pulse/preview_card/1?id=1").
         to_return(status: 200, body: "", headers: {})

      begin
        pulse_html = client.pulse_preview_card(id: 1)
        expect(pulse_html).to be_kind_of(String)
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/pulse/preview_card/#{id}}")
      end
    end
    
    ####################################################################################################################
    # pulse delete_subscription() test
    ####################################################################################################################
    it 'Unsubscribes user from pulse subscription' do

      stub_request(:delete, "#{host}/api/pulse/1/subscription?id=1")
        .to_return(status: 200, body: 'OK')


      pulse_json = client.delete_subscription(id: 1)

      expect(pulse_json).to eq('OK')

    end

    it 'Creates pulse' do
      stub_request(:post, "http://localhost:3030/api/pulse").
      with(body: "{\"name\":\"Create pulse test\"}")
        .to_return(status: 200, body: "OK", headers: {})
      
      expect(client.create_pulse(name: "Create pulse test")).to eq('OK')
    end
    
    ##############################################################################################################################
    #PUT Test_Pulse Test
    ##############################################################################################################################
    it 'Test sends an unsaved pulse' do

      stub_request(:post, "http://localhost:3030/api/pulse/test").
         with(body: "{\"name\":\"Jack\",\"cards\":[{\"id\":8,\"include_csv\":\"False\",\"include_xls\":\"False\",\"dashboard_card_id\":15}],\"channels\":[{\"id\":1}]}").
         to_return(status: 200, body: "OK", headers: {})
     



      pulse_test = client.pulse_test(name: 'Jack', cards: [{
                                       id: 8,
                                       include_csv: 'False',
                                       include_xls: 'False',
                                       dashboard_card_id: 15
                                     }],
                                     channels: [{ id: 1 }])

      expect(pulse_test).to eq('OK')
    end
    
    it 'Fetch Preview Card Info' do
      stub_request(:get, "#{host}/api/pulse/preview_card_info/1?id=1")
        .to_return(status: 200, body: 'OK')

      expect(client.preview_card_info(id: 1)).to have_requested(:get, "#{host}/api/pulse/preview_card_info/1?id=1")
    end
    
    it 'Get PNG rendering of a Card with id' do
      stub_request(:get, "#{host}/api/pulse/preview_card_png/1?id=1")
        .to_return(status: 200, body: 'OK')
    end

    it 'Get form input' do
      stub_request(:get, "#{host}/api/pulse/form_input")
        .to_return(status: 200, body: 'OK')

      expect(client.form_input).to have_requested(:get, "#{host}/api/pulse/form_input")
    end
    
    ##############################################################################################################################
    #PUT Pulse Update Test
    ##############################################################################################################################
    it 'Updates a Pulse with id' do
      stub_request(:put, "http://localhost:3030/api/pulse/1").
       with(body: "{\"id\":1,\"name\":\"Update pulse test\"}")
       .to_return(status: 200, body: "OK", headers: {})

      expect(client.update_pulse(id: 1, name: "Update pulse test")).to eq('OK')
    end
  end
end
