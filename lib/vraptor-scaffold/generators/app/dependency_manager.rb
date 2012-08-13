class DependencyManager

  attr_accessor :options

  def initialize(options)
    @options = options
  end

  def compile_scope
    [Dependency.new("br.com.caelum", "vraptor", "3.4.1"),
    Dependency.new("javax.servlet", "jstl", "1.2"),
    Dependency.new("org.hsqldb", "hsqldb", "2.2.8"),
    Dependency.new("org.hibernate", "hibernate-entitymanager", "4.0.1.Final"),
    Dependency.new("org.hibernate", "hibernate-c3p0", "4.0.1.Final"),
    Dependency.new("org.hibernate", "hibernate-validator", "4.2.0.Final"),
    Dependency.new("joda-time", "joda-time", "2.0"),
    Dependency.new("com.thoughtworks.xstream", "xstream", "1.4.1"),
    Dependency.new("com.google.code.gson", "gson", "2.2.1"),
    Dependency.new("org.codehaus.jettison", "jettison", "1.3"),
    Dependency.new("com.github.filipesperandio.vraptor", "vraptor-hypermedia", "3.4.1.9.deserializer"),
    Dependency.new("org.eclipse.jetty", "jetty-webapp", "7.4.4.v20110707"),
    Dependency.new("org.mortbay.jetty", "jsp-2.1-glassfish", "2.1.v20100127"),
    Dependency.new("javax.servlet", "servlet-api", "2.5")]
  end

  def test_scope
    [Dependency.new("junit", "junit", "4.10"),
    Dependency.new("org.hamcrest", "hamcrest-all", "1.1"),
    Dependency.new("org.mockito", "mockito-all", "1.9.0")]
  end

end
