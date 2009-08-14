class String
  def to_class_name
    self.split("_").each {|x| x.capitalize!}.join
  end

  # Showing props to ActiveSupport::Inflector
  def to_plugin_name
    self.to_s.gsub(/::/, '/').
      gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').
      gsub(/([a-z\d])([A-Z])/,'\1_\2').
      tr("-", "_").
      downcase
  end
end
