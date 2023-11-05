# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Util do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'gets all dashboards' do

      stub_request(:get, "#{host}/api/dashboard?f=all")
        .to_return(status: 200, body:
          '[
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 5,
        "show_in_getting_started": false,
        "name": "Orders Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:47:16.743",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 2,
        "position": null,
        "parameters": [
            {
                "id": "-1906860757",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "992992384",
                "type": "category",
                "name": "Source",
                "slug": "SOURCE"
            },
            {
                "id": "-1824399978",
                "type": "location/state",
                "name": "State",
                "slug": "STATE"
            },
            {
                "id": "-577791211",
                "type": "category",
                "name": "Category",
                "slug": "CATEGORY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:43:45.637",
        "public_uuid": null,
        "points_of_interest": null
    },
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 6,
        "show_in_getting_started": false,
        "name": "People Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:55:32.652",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 3,
        "position": null,
        "parameters": [
            {
                "id": "1753861257",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "992992384",
                "type": "category",
                "name": "Source",
                "slug": "SOURCE"
            },
            {
                "id": "-1824399978",
                "type": "location/state",
                "name": "State",
                "slug": "STATE"
            },
            {
                "id": "920030498",
                "type": "category",
                "name": "City",
                "slug": "CITY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:44:27.387",
        "public_uuid": null,
        "points_of_interest": null
    },
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 4,
        "show_in_getting_started": false,
        "name": "Products Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:43:17.05",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 1,
        "position": null,
        "parameters": [
            {
                "id": "585754392",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "-577791211",
                "type": "category",
                "name": "Category",
                "slug": "CATEGORY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:41:54.97",
        "public_uuid": null,
        "points_of_interest": null
    },
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 7,
        "show_in_getting_started": false,
        "name": "Reviews Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:47:31.754",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 4,
        "position": null,
        "parameters": [
            {
                "id": "1135688955",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "-577791211",
                "type": "category",
                "name": "Category",
                "slug": "CATEGORY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:44:34.108",
        "public_uuid": null,
        "points_of_interest": null
    }
]')


      dashboards_json = client.dashboards(f: 'all')
      dashboards = JSON.parse(dashboards_json)

      expect(dashboards).to be_kind_of(Array)

    end

    it 'gets dashboards created by current user' do

      stub_request(:get, "#{host}/api/dashboard?f=mine")
        .to_return(status: 200, body:
          '[
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 5,
        "show_in_getting_started": false,
        "name": "Orders Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:47:16.743",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 2,
        "position": null,
        "parameters": [
            {
                "id": "-1906860757",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "992992384",
                "type": "category",
                "name": "Source",
                "slug": "SOURCE"
            },
            {
                "id": "-1824399978",
                "type": "location/state",
                "name": "State",
                "slug": "STATE"
            },
            {
                "id": "-577791211",
                "type": "category",
                "name": "Category",
                "slug": "CATEGORY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:43:45.637",
        "public_uuid": null,
        "points_of_interest": null
    },
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 6,
        "show_in_getting_started": false,
        "name": "People Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:55:32.652",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 3,
        "position": null,
        "parameters": [
            {
                "id": "1753861257",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "992992384",
                "type": "category",
                "name": "Source",
                "slug": "SOURCE"
            },
            {
                "id": "-1824399978",
                "type": "location/state",
                "name": "State",
                "slug": "STATE"
            },
            {
                "id": "920030498",
                "type": "category",
                "name": "City",
                "slug": "CITY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:44:27.387",
        "public_uuid": null,
        "points_of_interest": null
    },
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 4,
        "show_in_getting_started": false,
        "name": "Products Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:43:17.05",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 1,
        "position": null,
        "parameters": [
            {
                "id": "585754392",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "-577791211",
                "type": "category",
                "name": "Category",
                "slug": "CATEGORY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:41:54.97",
        "public_uuid": null,
        "points_of_interest": null
    },
    {
        "description": null,
        "archived": false,
        "collection_position": 1,
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
        "enable_embedding": false,
        "collection_id": 7,
        "show_in_getting_started": false,
        "name": "Reviews Dashboard",
        "caveats": null,
        "creator_id": 1,
        "updated_at": "2020-06-07T05:47:31.754",
        "made_public_by_id": null,
        "embedding_params": null,
        "id": 4,
        "position": null,
        "parameters": [
            {
                "id": "1135688955",
                "type": "date/all-options",
                "name": "Created At",
                "slug": "CREATED_AT"
            },
            {
                "id": "-577791211",
                "type": "category",
                "name": "Category",
                "slug": "CATEGORY"
            }
        ],
        "favorite": false,
        "created_at": "2020-06-07T05:44:34.108",
        "public_uuid": null,
        "points_of_interest": null
    }
]')


      dashboards_json = client.dashboards(f: 'mine')
      dashboards = JSON.parse(dashboards_json)

      expect(dashboards).to be_kind_of(Array)
    end

    it 'gets dashboards that have been archived' do

      stub_request(:get, "#{host}/api/dashboard?f=archived")
        .to_return(status: 200, body: '[]')


      dashboards_json = client.dashboards(f: 'archived')
      dashboards = JSON.parse(dashboards_json)

      expect(dashboards).to be_kind_of(Array)
    end
  end
end
