class Object
  def local_methods
    (methods - Object.instance_methods).sort
  end
end
