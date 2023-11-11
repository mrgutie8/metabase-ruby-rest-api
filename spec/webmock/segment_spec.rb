# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Segment do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'fetches all segments' do

      stub_request(:get, "#{host}/api/segment")
        .to_return(status: 200, body:
          '[
              {
                  "description": "People from Twitter",
                  "archived": false,
                  "table_id": 3,
                  "definition": {
                      "source-table": 3,
                      "filter": [
                          "=",
                          [
                              "field-id",
                              24
                          ],
                          "Twitter"
                      ]
                  },
                  "creator": {
                      "email": "mb@example.com",
                      "first_name": "Admin",
                      "last_login": "2023-11-10T21:39:35.612",
                      "is_qbnewb": false,
                      "is_superuser": true,
                      "id": 1,
                      "last_name": "User",
                      "date_joined": "2020-06-07T05:20:41.859",
                      "common_name": "Admin User"
                  },
                  "show_in_getting_started": false,
                  "name": "People from Twitter",
                  "caveats": null,
                  "creator_id": 1,
                  "updated_at": "2020-06-07T06:23:50.069",
                  "id": 1,
                  "created_at": "2020-06-07T06:23:50.069",
                  "points_of_interest": null
              }
          ]')

      begin
        segments_json = client.segments
        segments = JSON.parse(segments_json)
        expect(segments).to be_kind_of(Array)
        expect(segments.length).to eq(1)
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/segment}")
      end
    end
  end
end
