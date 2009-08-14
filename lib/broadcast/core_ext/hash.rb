class Hash
  def keys_to_sym
    self.inject({}) do |hsh, (k, v)| 
      v = v.is_a?(Hash) ? v.keys_to_sym : v
      hsh[k.to_sym] = v
      hsh
    end
  end
end
