require 'net/http'
require 'open-uri'

require 'minitest/spec'

describe_recipe 'keystone::server' do

  describe 'keystone api server' do
    it 'should be running' do
      service(node['keystone']['platform']['keystone_service']).must_be_running
    end

    it 'should answer identity api requests' do
      parts = node['openstack']['endpoints']['identity-api']

      uri = URI::Generic.build(
        :scheme => parts['scheme'],
        :host => parts['host'],
        :port => parts['port'].to_i,
        :path => parts['path'])

      open(uri.to_s) do |r|
        assert_equal 'application/json', r.content_type
      end
    end

    it 'should answer identity admin requests' do
      parts = node['openstack']['endpoints']['identity-admin']

      uri = URI::Generic.build(
        :scheme => parts['scheme'],
        :host => parts['host'],
        :port => parts['port'].to_i,
        :path => parts['path'])

      open(uri.to_s) do |r|
        assert_equal 'application/json', r.content_type
      end
    end
  end
end
