require 'simplecov'
SimpleCov.start

require 'spec'
require 'spec/autorun'
require File.dirname(__FILE__) + '/../lib/vraptor-scaffold'

def build_attributes
  [Attribute.new("name", "string"), Attribute.new("myFlag", "boolean")]
end

def mock_config_file
  file = YAML.load_file File.join( File.dirname(__FILE__), "resources", "vraptor-scaffold.properties")
  Configuration.stub!(:config).and_return(file)
end

def mock_objectify_config_file
  file = YAML.load_file File.join( File.dirname(__FILE__), "resources", "vraptor-scaffold-objectify.properties")
  Configuration.stub!(:config).and_return(file)
end

def exists_and_identical?(source, created)
  c = sanitize(File.open(created).read)
  c2 = sanitize(File.open(source).read)
  c.should be == c2
end

private
def sanitize(text)
  text.gsub( /\r/m, "" ).gsub(/\n/m, "").gsub(/ /m, "")
end
