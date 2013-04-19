require 'minitest/spec'

include ::Openstack

describe_recipe 'keystone::db' do

  describe 'keystone db user' do
    it 'should have all the privileges on the keystone database' do
      db_info = node['openstack']['db']['identity']
      
      case db_info['db_type']
      when 'postgresql'
        require 'pg'
        conn = PG::Connection.new(
          :host => db_info['host'],
          :port => db_info['port'],
          :user => 'keystone',
          :password => db_password('keystone'))

        res = conn.exec "SELECT has_database_privilege('keystone', 'create')"
        res.check

        assert res.field_values "has_database_privilege"
      end
    end
  end
end

