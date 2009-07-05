class String
  def to_class_name
    self.split("_").each {|x| x.capitalize!}.join
  end
end
