class WebSocketIO

  def self.default_options
    {
      :port => [8080, lambda{|v| v.kind_of? Fixnum }]
    }
  end

  def self.options
    @@options ||= (
                   opts = {}
                   default_options.each do |k,v|
                     opts[k] = v[0]
                   end
                   opts
                   )
  end

  def self.options=(opts)
    @@options = {}
    opts.each do |k,v|
      k = k.to_sym
      if default_options.include? k
        @@options[k] = default_options[k][1].call(v) ? v : default_options[k][0]
      else
        @@options[k] = v
      end
    end
    default_options.each do |k, v|
      @@options[k] = v unless @@options.include? k
    end
    @@options
  end

end
