require 'open-uri'

require 'minitest/spec'

describe_recipe 'keystone::server' do

  describe 'keystone api server' do
    it 'should be running' do
      service(node['keystone']['platform']['keystone_service']).must_be_running
    end

    it 'should answer identity api requests' do
      uri = endpoint 'identity-api'

      open(uri.to_s) do |r|
        assert_equal 'application/json', r.content_type
      end
    end

    it 'should answer identity admin requests' do
      uri = endpoint 'identity-admin'
      open(uri.to_s) do |r|
        assert_equal 'application/json', r.content_type
      end
    end
  end
end
