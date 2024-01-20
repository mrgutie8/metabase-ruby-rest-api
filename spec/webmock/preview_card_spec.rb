# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Pulse do
  include_context 'login'

  let(:host) { 'localhost:3030' }
  let(:id) { '1' }

  context 'success' do
    it 'fetches HTML Rendering of a Card with id' do
      stub_request(:get, "http://localhost:3030/api/pulse/preview_card/1?id=1").
         with(
           headers: {
       	  'Accept'=>'*/*',
       	  'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3',
       	  'User-Agent'=>'MetabaseRuby/0.5.0 (ruby3.0.2)',
       	  'X-Metabase-Session'=>'bca8d83e-7d37-4670-81b6-560ac452773e'
           }).
         to_return(status: 200, body: "", headers: {})

      begin
        pulse_html = client.pulse_preview_card(id: 1)
        expect(pulse_html).to be_kind_of(String)
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/pulse/preview_card/#{id}}")
      end
    end
  end
end
