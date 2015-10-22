require 'spec_helper'
describe 'zipfile::gems' do

  it { should contain_class('zipfile::gems') }
  it { should contain_package('zipruby').with_provider('puppet_gem') }

end

