# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Revision do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'fetches all revisions' do
      stub_request(:get, "#{host}/api/revision?entity=card&id=1")
        .to_return(status: 200, body:
          '[
            {
                "description": "changed collection_id from \"null\" to \"2\".",
                "is_creation": false,
                "id": 2,
                "is_reversion": false,
                "timestamp": "2020-06-07T05:37:53.829",
                "user": {
                    "id": 1,
                    "first_name": "Admin",
                    "last_name": "User",
                    "common_name": "Admin User"
                },
                "message": null,
                "diff": {
                    "before": {
                        "collection_id": null
                    },
                    "after": {
                        "collection_id": 2
                    }
                }
            },
            {
                "description": null,
                "is_creation": true,
                "id": 1,
                "is_reversion": false,
                "timestamp": "2020-06-07T05:36:28.829",
                "user": {
                    "id": 1,
                    "first_name": "Admin",
                    "last_name": "User",
                    "common_name": "Admin User"
                },
                "message": null,
                "diff": null
            }
          ]')

      begin
        revisions_json = client.revisions(entity: :card, id: 1)
        revisions = JSON.parse(revisions_json)
        expect(revisions).to be_kind_of(Array)
      end
    end
  end
end
