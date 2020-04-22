require_relative '../simplecov_helper'
require_relative '../rspec_configuration.rb'
require_relative '../../lib/carto/uuidhelper'

class Carto::UUIDHelperInstance
  include Carto::UUIDHelper
end

describe 'UUIDHelper' do

  before(:each) do
    @uuid_helper = Carto::UUIDHelperInstance.new
  end

  it 'validates a valid UUID' do
    @uuid_helper.uuid?('5b632a9e-ae07-11e4-ac8d-080027880ca6').should be(true)
  end

  it 'validates a random UUID' do
    @uuid_helper.uuid?(Carto::UUIDHelper.random_uuid).should be(true)
  end

  it 'fails if content prepended' do
    @uuid_helper.uuid?("hi" + Carto::UUIDHelper.random_uuid).should be(false)
  end

  it 'fails if content appended' do
    @uuid_helper.uuid?(Carto::UUIDHelper.random_uuid + "hola").should be(false)
  end

  it 'fails if content prepended with newlines' do
    @uuid_helper.uuid?("hi\n" + Carto::UUIDHelper.random_uuid).should be(false)
  end

  it 'fails if content appended with newlines' do
    @uuid_helper.uuid?(Carto::UUIDHelper.random_uuid + "\nhola").should be(false)
  end

end
