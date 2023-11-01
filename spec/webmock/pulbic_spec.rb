# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Public do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Logs' do

      stub_request(:get, "#{host}/api/public/card/708a78ec-15c8-405e-b590-de98c6ddfa01")
        .to_return(status: 200, body: 'OK')

      expect(client.public_card('708a78ec-15c8-405e-b590-de98c6ddfa01')).to eq('OK')
    end

  end


end
