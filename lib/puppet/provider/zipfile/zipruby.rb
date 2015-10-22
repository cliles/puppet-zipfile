Puppet::Type.type(:zipfile).provide(:zipruby, :parent => Puppet::Provider) do

  desc "Zipruby provider for zipfile managmenet."

  confine  :feature => [ :zipruby ]

  if Puppet.features.zipruby?
    require 'zipruby'
  end

  def create
    Zip::Archive.open(@resource[:zip], Zip::CREATE) do |z|
      z.add_buffer(@resource[:file], @resource[:content])
    end
  end

  def destroy
    Zip::Archive.open(@resource[:zip]) do |z|
      n = z.num_files
      n.times do |i|
        entry_name = z.get_name(i)
        z.fdelete(i) if entry_name === @resource[:file]
      end
    end
  end

  def exists?
    begin
      Zip::Archive.open(@resource[:zip]) do |z|
        content=z.fopen(@resource[:file]).read
      end
    rescue Exception => e
      debug(e.message)
      return false
    end
    return true
  end

  def content
    if File.exists?(@resource[:zip])
      content = nil
        begin
          Zip::Archive.open(@resource[:zip]) do |z|
            content=z.fopen(@resource[:file]).read
          end
        rescue Exception => e
          raise Puppet::Error, e.message
        end
        ret = nil
        if not content
          debug("File does not exist in zipfile (#{@resource[:file]})")
          :absent
        elsif @resource[:content]
          require 'digest/md5'
          a = Digest::MD5.hexdigest(content)
          b = Digest::MD5.hexdigest(@resource[:content])
          debug("Comparing content of #{a} with #{b}")
          if a == b
            return @resource[:content]
          else
            return content
          end
        else
          debug("No provided content, but its ok, because its not supposed to be there")
          return content ? :present : :absent
        end
    else
      :absent
    end
  end

  def content=(value)
    self.class.send_log(:debug, "call content=(#{value})")
    Zip::Archive.open(@resource[:zip]) do |z|
      z.replace_buffer(@resource[:file], @resource[:content])
    end
  end

end
