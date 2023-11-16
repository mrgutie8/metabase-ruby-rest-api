# frozen_string_literal: true

RSpec.describe Metabase::Endpoint::Session do
  include_context 'client'
  let(:host) { 'http://localhost:3030' }

  describe 'login' do
    let(:incorrect_password) do
      Metabase::Client.new(
        url: 'http://localhost:3030',
        username: 'mb@example.com',
        password: 'incorrect'
      )
    end

    context 'success' do
      it 'returns a session token' do
        stub_request(:post, "#{host}/api/session")
          .with(
            body: '{"username":"mb@example.com","password":"p@ssw0rd"}'
          )
          .to_return(status: 200, body: 'OK')

        expect(client.login).to have_requested(:post, "#{host}/api/session")
                                  .with(body: '{"username":"mb@example.com","password":"p@ssw0rd"}')
      end
    end

    context 'incorrect username or password' do
      it 'raises error' do

        stub_request(:post, "#{host}/api/session")
          .with(
            body: '{"username":"mb@example.com","password":"incorrect"}'
          )
          .to_return(status: 400)

        expect { incorrect_password.login }.to raise_error(Metabase::BadRequest)
      end
    end

    context 'specify username and password' do
      it 'uses the username and password' do

        stub_request(:post, "#{host}/api/session")
          .with(
            body: '{"username":"mb@example.com","password":"p@ssw0rd"}'
          )
          .to_return(status: 200, body: 'OK')

        params = { username: 'mb@example.com', password: 'p@ssw0rd' }
        expect(incorrect_password.login(**params)).to have_requested(:post, "#{host}/api/session")
                                  .with(body: '{"username":"mb@example.com","password":"p@ssw0rd"}')
      end
    end
  end

  describe 'logout' do
    context 'success' do
      include_context 'login'
      it 'returns true' do
        stub_request(:delete, "#{host}/api/session?session_id=bca8d83e-7d37-4670-81b6-560ac452773e")
          .to_return(status: 200, body: 'OK')

        expect(client.logout).to have_requested(:delete, "#{host}/api/session?session_id=bca8d83e-7d37-4670-81b6-560ac452773e")
      end
    end
  end
end
