require 'spec_helper'

RSpec.describe Metabase::Endpoint::User do
  include_context 'login'

  context 'success' do
    it 'Fetches Current User' do
      body = {
        "email" => "mb@example.com",
        "first_name"=> "Admin",
        "id"=> 1,
        "last_name"=> "User",
      }

      stub_request(:get, 'http://localhost:3030/api/user/current')
        .to_return(status: 200, body: body.to_json)

      user_json = client.current_user
      user = JSON.parse(user_json)

      # Assert the response and test your code's behavior
      expect(user['email']).to eq('mb@example.com')
    end

    ###################################################################################################################
    # GET USER TEST
    # #################################################################################################################
    it 'Fetches a list of Users' do
      body = [
        {
          "email" => "mb@example.com",
          "first_name"=> "Admin",
          "id"=> 1,
          "last_name"=> "User",
        },
        {
          "email" => "mb1@example.com",
          "first_name"=> "Admin1",
          "id"=> 2,
          "last_name"=> "User1",
        }
      ]

      stub_request(:get, 'http://localhost:3030/api/user')
        .to_return(status: 200, body: body.to_json)

      user_json = client.users
      users = JSON.parse(user_json)

      # Assert the response and test your code's behavior
      expect(users[0]['email']).to eq('mb@example.com')
    end
  end
end