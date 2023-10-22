require 'spec_helper'

RSpec.describe Metabase::Endpoint::User do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches Current User' do
      body = {
        'email' => 'mb@example.com',
        'first_name'=> 'Admin',
        'id'=> 1,
        'last_name'=> 'User'
      }

      stub_request(:get, "#{host}/api/user/current")
        .to_return(status: 200, body: body.to_json)

      begin
        user_json = client.current_user
        user = JSON.parse(user_json)

        expect(user['email']).to eq('mb@example.com')
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/user/current")
      end
    end

    ###################################################################################################################
    # GET USER Recipients TEST
    # #################################################################################################################
    it 'Fetches user recipients' do
      body = [
        {
          "email" => "mb@example.com",
          "first_name"=> "Admin",
          "id"=> 1,
          "last_name"=> "User"
        },
        {
          "email" => "mb1@example.com",
          "first_name"=> "Admin1",
          "id"=> 2,
          "last_name"=> "User1"
        }
      ]

      stub_request(:get, 'http://localhost:3030/api/user/recipients')
        .to_return(status: 200, body: body.to_json)

      user_json = client.recipients
      users = JSON.parse(user_json)

      # Assert the response and test your code's behavior
      expect(users.length).to eq(2)
    end


    ###################################################################################################################
    # REACTIVATE USER TEST
    # #################################################################################################################
    it 'Reactivates User' do
      body = {
        'is_active' => true,
        'id' => 3
      }

      stub_request(:put, "#{host}/api/user/3/reactivate")
        .to_return(status: 200, body: body.to_json)

      begin
        user_json = client.reactivate(id: 3)
        user = JSON.parse(user_json)

        expect(user['is_active']).to eq(true)
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/user/3/reactivate")
      end
    end

    context 'user already exists to reactivate' do
      before do
        stub_request(:put, "#{host}/api/user/3/reactivate")
          .to_return(status: 400, body: 'BadRequest')
      end

      it 'should return error' do
        message = %r{^PUT http://#{host}/api/user/3/reactivate: 400 - BadRequest}
        expect { client.reactivate(id: 3) }
          .to raise_error(Metabase::BadRequest, message)
      end
    end

    ###################################################################################################################
    # DELETE USER TEST
    # #################################################################################################################
    it 'Disables a user' do
      body = {
        'success' => 'true'
      }

      stub_request(:delete, "#{host}/api/user/2?id=2")
        .to_return(status: 200, body: body.to_json)

      response_json = client.delete_user(id: 2)
      response = JSON.parse(response_json)

      # Assert the response and test your code's behavior
      expect(response['success']).to eq('true')
    end
    # user delete failure case
    it 'Fails to disable non-existent user' do
      body = {
        'success' => 'false'
      }

      stub_request(:delete, "#{host}/api/user/10?id=10")
        .to_return(status: 200, body: body.to_json)

      response_json = client.delete_user(id: 10)
      response = JSON.parse(response_json)

      # Assert the response and test your code's behavior
      expect(response['success']).to eq('false')
    end
  end
end
