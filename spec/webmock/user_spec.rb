require 'spec_helper'

RSpec.describe Metabase::Endpoint::User do
  include_context 'login'

  context 'success' do
    it 'Fetches Current User' do
      body = {
        'email' => 'mb@example.com',
        'first_name'=> 'Admin',
        'id'=> 1,
        'last_name'=> 'User'
      }

      stub_request(:get, 'http://localhost:3030/api/user/current')
        .to_return(status: 200, body: body.to_json)

      begin
        user_json = client.current_user
        user = JSON.parse(user_json)
  
        expect(user['email']).to eq('mb@example.com')
      rescue StandardError
        expect(WebMock).to have_requested(:put, 'http://localhost:3030/api/user/current')
      end
    end

    it 'Reactivates User' do
      body = {
        'is_active' => true,
        'id' => 3
      }

      stub_request(:put, 'http://localhost:3030/api/user/3/reactivate')
        .to_return(status: 200, body: body.to_json)

      begin
        user_json = client.reactivate(id: 3)
        user = JSON.parse(user_json)

        expect(user['is_active']).to eq(true)
      rescue StandardError
        expect(WebMock).to have_requested(:put, 'http://localhost:3030/api/user/3/reactivate')
      end
    end

    ###################################################################################################################
    # DELETE USER TEST
    # #################################################################################################################
    it 'Disables a user' do
      body = {
        'success' => 'true'
      }

      stub_request(:delete, 'http://localhost:3030/api/user/2?id=2')
        .to_return(status: 200, body: body.to_json)

      responce_json = client.delete_user(id: 2)
      responce = JSON.parse(responce_json)

      # Assert the response and test your code's behavior
      expect(responce['success']).to eq('true')
    end
    # user delete failure case
    it 'Fails to disable non-existent user' do
      body = {
        'success' => 'false'
      }

      stub_request(:delete, 'http://localhost:3030/api/user/10?id=10')
        .to_return(status: 200, body: body.to_json)

      responce_json = client.delete_user(id: 10)
      responce = JSON.parse(responce_json)

      # Assert the response and test your code's behavior
      expect(responce['success']).to eq('false')
    end
  end
end
