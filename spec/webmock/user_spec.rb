require 'spec_helper'

RSpec.describe Metabase::Endpoint::User do
  include_context 'login'

  let(:host) { 'localhost:3030' }

  context 'success' do
    it 'Fetches Current User' do
      body = {
        'email' => 'mb@example.com',
        'first_name' => 'Admin',
        'id' => 1,
        'last_name' => 'User'
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

    ###################################################################################################################
    # UPDATE USER TEST
    # #################################################################################################################
    it 'Updates User' do
      stub_request(:put, "#{host}/api/user/3")
        .to_return(status: 200, body: { email: 'test@metabase.com' }.to_json)

      begin
        user_json = client.update_user(id: 3)
        user = JSON.parse(user_json)

        expect(user['email']).to eq('test@metabase.com')
      rescue StandardError
        expect(WebMock).to have_requested(:put, "#{host}/api/user/3")
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

    ###################################################################################################################
    # POST USER TEST
    # #################################################################################################################
    it 'Creates a new user' do
      body = {
        'first_name' => 'Jack',
        'last_name' => 'Smith',
        'email' => 'jack.smith@email.com'
      }

      stub_request(:post, "#{host}/api/user")
        .to_return(status: 200, body: body.to_json)

      response_json = client.create_user(first_name: 'Jack', last_name: 'Smith', email: 'jack.smith@email.com',
                                         user_group_memberships: nil, login_attributes: nil)
      new_user = JSON.parse(response_json)

      # Assert the response and test your code's behavior
      expect(new_user['email']).to eq('jack.smith@email.com')
    end
    # tries to create a user with an existing email
    context 'Failed to create user with same email' do
      before do
        stub_request(:post, "#{host}/api/user")
          .to_return(status: 400, body: 'BadRequest')
      end

      it 'should return error' do
        message = %r{^POST http://#{host}/api/user: 400 - BadRequest}
        expect do
          client.create_user(first_name: 'Jack', last_name: 'Smith', email: 'jack.smith@email.com',
                             user_group_memberships: nil, login_attributes: nil)
        end
          .to raise_error(Metabase::BadRequest, message)
      end
    end
  end

  # Error user test
  context 'error' do
    context 'email already exists when updating' do
      before do
        stub_request(:put, "#{host}/api/user/3")
          .to_return(status: 400, body: 'BadRequest')
      end

      it 'should return error' do
        message = %r{^PUT http://#{host}/api/user/3: 400 - BadRequest}
        expect { client.update_user(id: 3) }
          .to raise_error(Metabase::BadRequest, message)
      end
    end

    context 'email already active when reactivating' do
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
  end
end
