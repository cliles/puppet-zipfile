require 'spec_helper'

describe Puppet::Type.type(:zipfile) do

  describe 'when validating attributes' do
    [ :name, :provider, :zip, :file ].each do |param|
      it "should have a #{param} parameter" do
        expect(described_class.attrtype(param)).to eq(:param)
      end
    end

    [ :ensure, :content ].each do |prop|
      it "should have a #{prop} property" do
        expect(described_class.attrtype(prop)).to eq(:property)
      end
    end
  end

end
