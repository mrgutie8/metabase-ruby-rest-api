# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Util do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches all PermissionsGroups' do

      stub_request(:get, "#{host}/api/permissions/group")
        .to_return(status: 200, body:
          '[
    {
        "id": 2,
        "name": "Administrators",
        "member_count": 1
    },
    {
        "id": 1,
        "name": "All Users",
        "member_count": 4
    },
    {
        "id": 4,
        "name": "MetabaseRuby",
        "member_count": 1
    }
]')


      groups_json = client.groups
      groups = JSON.parse(groups_json)

      expect(groups).to be_kind_of(Array)

    end
  end
end
