require 'spec_helper'

RSpec.describe Metabase::Endpoint::Card do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do

    it 'Fetches Card detail' do
      body = {
        'id' => 1,
        'name' => 'Card 1',
        'description' => 'Card 1',
        'display' => 'Card 1 display',
        'collection_position' => 1,
        'collection_id' => 1
      }
        

      stub_request(:get, "#{host}/api/card/1")
      .to_return(status: 200, body: body.to_json)
      

      begin
        card_json = client.card(1)
        card = JSON.parse(card_json)

        expect(card['name']).to eq('Card 1')
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/card/1")
      end
    end
  end
end
