class Hash
  def symbolize_keys
    self.inject({}) do |hsh, (k, v)| 
      v = v.is_a?(Hash) ? v.symbolize_keys : v
      hsh[k.to_sym] = v
      hsh
    end
  end
end
