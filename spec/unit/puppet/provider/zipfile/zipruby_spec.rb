require 'spec_helper'
require 'zipruby'

describe Puppet::Type.type(:zipfile).provider(:zipruby) do

  testfile = '/tmp/rspec_test.zip'

  let(:params) do
    {
      :name     => 'spec_zip',
      :zip      => testfile,
      :file     => 'inside.txt',
      :content  => 'HelloWorld!',
      :provider => described_class.name
    }
  end

  let(:resource) do
    Puppet::Type.type(:zipfile).new(params)
  end

  let(:provider) do
    resource.provider
  end

  before :each do
    if File.exists?(testfile)
      File.delete(testfile)
    end
  end

  after :all do
    if File.exists?(testfile)
      File.delete(testfile)
    end
  end

  describe 'creates' do
    it 'Creates a new zipfile with content' do
      expect(provider.exists?).to be false
      expect(provider.create).to be_nil
      expect(provider.exists?).to be true
    end

    it 'Adds content to an existing zipfile' do
      Zip::Archive.open(testfile, Zip::CREATE) do |z|
        z.add_buffer('dummyfile', 'dummycontent')
      end
      expect(provider.exists?).to be false
      expect(provider.create).to be_nil
      expect(provider.exists?).to be true
    end
  end

  describe 'change' do
    it 'Changes content to an existing zipfile' do
      Zip::Archive.open(testfile, Zip::CREATE) do |z|
        z.add_buffer(params[:file], 'dummycontent')
      end
      expect(provider.content=params[:content]).to eql('HelloWorld!') 
      expect(provider.content()).to eql('HelloWorld!') 
    end
  end

end
