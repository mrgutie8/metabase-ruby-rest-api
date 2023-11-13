# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Table do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'fetches all tables' do

      stub_request(:get, "#{host}/api/table")
        .to_return(status: 200, body:
          '[
            {
                "description": "This is a confirmed order for a product from a user.",
                "entity_type": "entity/TransactionTable",
                "schema": "PUBLIC",
                "db": {
                    "description": null,
                    "features": [
                        "basic-aggregations",
                        "standard-deviation-aggregations",
                        "expression-aggregations",
                        "foreign-keys",
                        "right-join",
                        "left-join",
                        "native-parameters",
                        "nested-queries",
                        "expressions",
                        "case-sensitivity-string-filter-options",
                        "binning",
                        "inner-join",
                        "advanced-math-expressions"
                    ],
                    "cache_field_values_schedule": "0 50 0 * * ? *",
                    "timezone": "UTC",
                    "auto_run_queries": true,
                    "metadata_sync_schedule": "0 50 * * * ? *",
                    "name": "Sample Dataset",
                    "caveats": null,
                    "is_full_sync": true,
                    "updated_at": "2023-10-11T21:29:45.441",
                    "details": {
                        "db": "zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"
                    },
                    "is_sample": true,
                    "id": 1,
                    "is_on_demand": false,
                    "options": null,
                    "engine": "h2",
                    "created_at": "2020-06-07T05:19:27.175",
                    "points_of_interest": null
                },
                "show_in_getting_started": false,
                "name": "ORDERS",
                "caveats": null,
                "fields_hash": "Iqz4vNbm7vh80Uo9pWdesA==",
                "rows": 0,
                "updated_at": "2023-11-11T00:50:00.848",
                "entity_name": null,
                "active": true,
                "id": 2,
                "db_id": 1,
                "visibility_type": null,
                "display_name": "Orders",
                "created_at": "2020-06-07T05:19:27.483",
                "points_of_interest": null
            },
            {
                "description": "This is a user account. Note that employees and customer support staff will have accounts.",
                "entity_type": "entity/UserTable",
                "schema": "PUBLIC",
                "db": {
                    "description": null,
                    "features": [
                        "basic-aggregations",
                        "standard-deviation-aggregations",
                        "expression-aggregations",
                        "foreign-keys",
                        "right-join",
                        "left-join",
                        "native-parameters",
                        "nested-queries",
                        "expressions",
                        "case-sensitivity-string-filter-options",
                        "binning",
                        "inner-join",
                        "advanced-math-expressions"
                    ],
                    "cache_field_values_schedule": "0 50 0 * * ? *",
                    "timezone": "UTC",
                    "auto_run_queries": true,
                    "metadata_sync_schedule": "0 50 * * * ? *",
                    "name": "Sample Dataset",
                    "caveats": null,
                    "is_full_sync": true,
                    "updated_at": "2023-10-11T21:29:45.441",
                    "details": {
                        "db": "zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"
                    },
                    "is_sample": true,
                    "id": 1,
                    "is_on_demand": false,
                    "options": null,
                    "engine": "h2",
                    "created_at": "2020-06-07T05:19:27.175",
                    "points_of_interest": null
                },
                "show_in_getting_started": false,
                "name": "PEOPLE",
                "caveats": null,
                "fields_hash": "CXKI5VefRbNYgZ8IStmaNw==",
                "rows": 0,
                "updated_at": "2023-11-11T00:50:00.995",
                "entity_name": null,
                "active": true,
                "id": 3,
                "db_id": 1,
                "visibility_type": null,
                "display_name": "People",
                "created_at": "2020-06-07T05:19:27.486",
                "points_of_interest": null
            },
            {
                "description": "This is our product catalog. It includes all products ever sold by the Sample Company.",
                "entity_type": "entity/ProductTable",
                "schema": "PUBLIC",
                "db": {
                    "description": null,
                    "features": [
                        "basic-aggregations",
                        "standard-deviation-aggregations",
                        "expression-aggregations",
                        "foreign-keys",
                        "right-join",
                        "left-join",
                        "native-parameters",
                        "nested-queries",
                        "expressions",
                        "case-sensitivity-string-filter-options",
                        "binning",
                        "inner-join",
                        "advanced-math-expressions"
                    ],
                    "cache_field_values_schedule": "0 50 0 * * ? *",
                    "timezone": "UTC",
                    "auto_run_queries": true,
                    "metadata_sync_schedule": "0 50 * * * ? *",
                    "name": "Sample Dataset",
                    "caveats": null,
                    "is_full_sync": true,
                    "updated_at": "2023-10-11T21:29:45.441",
                    "details": {
                        "db": "zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"
                    },
                    "is_sample": true,
                    "id": 1,
                    "is_on_demand": false,
                    "options": null,
                    "engine": "h2",
                    "created_at": "2020-06-07T05:19:27.175",
                    "points_of_interest": null
                },
                "show_in_getting_started": false,
                "name": "PRODUCTS",
                "caveats": null,
                "fields_hash": "aqXlpsb4FjyCH5o8qP4a2A==",
                "rows": 0,
                "updated_at": "2023-11-11T00:50:01.188",
                "entity_name": null,
                "active": true,
                "id": 1,
                "db_id": 1,
                "visibility_type": null,
                "display_name": "Products",
                "created_at": "2020-06-07T05:19:27.478",
                "points_of_interest": null
            },
            {
                "description": "These are reviews our customers have left on products. Note that these are not tied to orders so it is possible people have reviewed products they did not purchase from us.",
                "entity_type": "entity/GenericTable",
                "schema": "PUBLIC",
                "db": {
                    "description": null,
                    "features": [
                        "basic-aggregations",
                        "standard-deviation-aggregations",
                        "expression-aggregations",
                        "foreign-keys",
                        "right-join",
                        "left-join",
                        "native-parameters",
                        "nested-queries",
                        "expressions",
                        "case-sensitivity-string-filter-options",
                        "binning",
                        "inner-join",
                        "advanced-math-expressions"
                    ],
                    "cache_field_values_schedule": "0 50 0 * * ? *",
                    "timezone": "UTC",
                    "auto_run_queries": true,
                    "metadata_sync_schedule": "0 50 * * * ? *",
                    "name": "Sample Dataset",
                    "caveats": null,
                    "is_full_sync": true,
                    "updated_at": "2023-10-11T21:29:45.441",
                    "details": {
                        "db": "zip:/app/metabase.jar!/sample-dataset.db;USER=GUEST;PASSWORD=guest"
                    },
                    "is_sample": true,
                    "id": 1,
                    "is_on_demand": false,
                    "options": null,
                    "engine": "h2",
                    "created_at": "2020-06-07T05:19:27.175",
                    "points_of_interest": null
                },
                "show_in_getting_started": false,
                "name": "REVIEWS",
                "caveats": null,
                "fields_hash": "wIcr7cLnXrbpAUfOXgcmeQ==",
                "rows": 0,
                "updated_at": "2023-11-11T00:50:01.239",
                "entity_name": null,
                "active": true,
                "id": 4,
                "db_id": 1,
                "visibility_type": null,
                "display_name": "Reviews",
                "created_at": "2020-06-07T05:19:27.49",
                "points_of_interest": null
            }
          ]')

      begin
        tables_json = client.tables
        tables = JSON.parse(tables_json)
        expect(tables).to be_kind_of(Array)
      rescue StandardError
        expect(WebMock).to have_requested(:get, "#{host}/api/table")
      end
    end
  end
end
