Puppet::Type.newtype(:zipfile) do
  @doc = "Ensure contents of file within a zip file"

  newparam(:name) do
    desc "The name of the resource"
  end

  newparam(:zip) do
    desc "The path to the zip file which contains the file"
  end

  newparam(:file) do
    desc "The file path within the zip file"
  end

  newproperty(:content) do
    desc "The contents of the file within the zip file"
  end

  ensurable

    
  autorequire(:zip) do
    auto_requires = []
    [:zip].each do |param|
      if @parameters.include?(param)
	      auto_requires << @parameters[param].value
	    end
    end
    auto_requires
  end

end
