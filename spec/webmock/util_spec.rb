# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Util do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Logs' do

      stub_request(:get, "#{host}/api/util/logs")
        .to_return(status: 200, body:
          '[
            {
              "timestamp": "2023-10-26T23:56:04.104Z",
              "level": "DEBUG",
              "fqns": "metabase.middleware.log",
              "msg":"",
              "exception": null,
              "process_uuid": "171bab1f-a50f-4cd7-9ea7-e35f71597333"
            },
            {
              "timestamp": "2023-10-26T23:54:27.134Z",
              "level": "DEBUG",
              "fqns": "metabase.middleware.log",
              "msg":"",
              "exception": null,
              "process_uuid": "171bab1f-a50f-4cd7-9ea7-e35f71597333"
            },
            {
              "timestamp": "2023-10-26T23:54:02.794Z",
              "level": "DEBUG",
              "fqns": "metabase.middleware.log",
              "msg":"",
              "exception": null,
              "process_uuid": "171bab1f-a50f-4cd7-9ea7-e35f71597333"
            },
            {
              "timestamp": "2023-10-26T23:52:58.590Z",
              "level": "DEBUG",
              "fqns": "metabase.middleware.log",
              "msg":"",
              "exception": null,
              "process_uuid": "171bab1f-a50f-4cd7-9ea7-e35f71597333"
            }
          ]')


      logs_json = client.logs
      logs = JSON.parse(logs_json)

      expect(logs).to be_kind_of(Array)

    end

  end


end
