class Attribute
  attr_accessor :name, :type

  def initialize(name, type)
    @name = name.underscore.camelize(:lower)
    @type = type.downcase
    validate
  end

  def html_input
    input = "text"
    input = "checkbox" if boolean?
    input = "textarea" if text?
    input
  end

  def html_label
    @name.underscore.humanize
  end

  def java_type
    java = type.capitalize
    java = "boolean" if boolean?
    java = "String" if text?
    java
  end

  def self.valid_types
    %w(boolean double float short integer long string text)
  end

  def boolean?
    @type.eql? "boolean"
  end

  def text?
      @type.eql? "text"
  end

  def getter_prefix
    return "is" if boolean?
    "get"
  end

  def validate
    unless Attribute.valid_types.include?(@type)
      puts "Attribute #{@type} is not supported. The supported attributes types are: #{Attribute.valid_types.join(", ")}"
      Kernel::exit
    end
  end
end
