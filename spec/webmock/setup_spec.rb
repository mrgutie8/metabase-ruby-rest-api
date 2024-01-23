# frozen_string_literal: true

require 'spec_helper'

RSpec.describe Metabase::Endpoint::Util do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Returns various admin checklist steps and if they have been completed do' do

      stub_request(:get, "#{host}/api/setup/admin_checklist")
        .to_return(status: 200, body:
          '[
    {
        "name": "Get connected",
        "tasks": [
            {
                "title": "Add a database",
                "group": "Get connected",
                "description": "Connect to your data so your whole team can start to explore.",
                "link": "/admin/databases/create",
                "completed": false,
                "triggered": true,
                "is_next_step": true
            },
            {
                "title": "Set up email",
                "group": "Get connected",
                "description": "Add email credentials so you can more easily invite team members and get updates via Pulses.",
                "link": "/admin/settings/email",
                "completed": false,
                "triggered": true,
                "is_next_step": false
            },
            {
                "title": "Set Slack credentials",
                "group": "Get connected",
                "description": "Does your team use Slack? If so, you can send automated updates via pulses and ask questions with MetaBot.",
                "link": "/admin/settings/slack",
                "completed": true,
                "triggered": true,
                "is_next_step": false
            },
            {
                "title": "Invite team members",
                "group": "Get connected",
                "description": "Share answers and data with the rest of your team.",
                "link": "/admin/people/",
                "completed": true,
                "triggered": true,
                "is_next_step": false
            }
        ]
    },
    {
        "name": "Curate your data",
        "tasks": [
            {
                "title": "Hide irrelevant tables",
                "group": "Curate your data",
                "description": "If your data contains technical or irrelevant info you can hide it.",
                "link": "/admin/datamodel/database",
                "completed": false,
                "triggered": false,
                "is_next_step": false
            },
            {
                "title": "Organize questions",
                "group": "Curate your data",
                "description": "Have a lot of saved questions in Metabase? Create collections to help manage them and add context.",
                "link": "/collection/root",
                "completed": true,
                "triggered": true,
                "is_next_step": false
            },
            {
                "title": "Create metrics",
                "group": "Curate your data",
                "description": "Define canonical metrics to make it easier for the rest of your team to get the right answers.",
                "link": "/admin/datamodel/database",
                "completed": true,
                "triggered": true,
                "is_next_step": false
            },
            {
                "title": "Create segments",
                "group": "Curate your data",
                "description": "Keep everyone on the same page by creating canonical sets of filters anyone can use while asking questions.",
                "link": "/admin/datamodel/database",
                "completed": true,
                "triggered": true,
                "is_next_step": false
            }
        ]
    }
]')


    checklist_json = client.admin_checklists
    checklist = JSON.parse(checklist_json)

      expect(checklist).to be_kind_of(Array)

    end
  end
end
