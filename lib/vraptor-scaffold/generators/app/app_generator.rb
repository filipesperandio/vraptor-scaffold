class AppGenerator < VraptorScaffold::Base

  ORMS = %w( jpa hibernate )

  argument :project_path

  class_option :package, :default => "app", :aliases => "-p",
               :desc => "Define base package"

  class_option :models_package, :aliases => "-m", :default => "models",
               :desc => "Define models package"

  class_option :controllers_package, :aliases => "-c", :default => "controllers",
               :desc => "Define controllers package"

  class_option :repositories_package, :aliases => "-r", :default => "repositories",
               :desc => "Define repositories package"

  class_option :orm, :default => "jpa", :aliases => "-o",
               :desc => "Object-relational mapping (options: #{ORMS.join(', ')})"

  def self.source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def self.banner
    "vraptor new #{self.arguments.map(&:usage).join(' ')} [options]"
  end

  def initialize(args, opts=[])
    super([args], opts)
    validate
    self.destination_root=(project_path)
    @project_name = project_path.split("/").last
    @dependency_manager = DependencyManager.new(options)
    @javascripts = Configuration::JAVASCRIPTS
    @stylesheets = Configuration::STYLESHEETS
    @images = Configuration::IMAGES
    @img = File.join Configuration::WEB_APP, "img"
  end

  def create_root_folder
    empty_directory "."
    copy_file("heroku/Procfile", "Procfile")
  end

  def configure_maven
    template("pom.erb", "pom.xml") 
  end

  def configure_vraptor_packages
    vraptor_util_package = "br.com.caelum.vraptor"
    @vraptor_packages = []
    @vraptor_packages += ["#{vraptor_util_package}.util.#{orm}"] if orm == "jpa" or orm == "hibernate"
  end

  def create_main_java
    empty_directory Configuration::MAIN_SRC
    @src = File.join(Configuration::MAIN_SRC, options[:package].gsub(".", File::Separator))
    copy_file("heroku/Main.java", "#{Configuration::MAIN_SRC}/Main.java")
  end

  def create_controllers_directory
    empty_directory File.join @src, options[:controllers_package]
  end

  def create_models_directory
    models_folder = File.join @src, options[:models_package]
    empty_directory models_folder
    template("models/Entity.erb", "#{models_folder}/Entity.java") 
  end

  def create_repositories_directory
    repositories_folder = File.join @src, options[:repositories_package]
    empty_directory repositories_folder
    template("orm/Repository-#{orm}.java.tt", "#{repositories_folder}/Repository.java")
  end

  def create_main_resources
    directory("resources", Configuration::MAIN_RESOURCES)
  end

  def configure_orm
    if (orm == "hibernate")
      copy_file("orm/hibernate.cfg.xml", (File.join Configuration::MAIN_RESOURCES, "hibernate.cfg.xml"))
    else
      metainf = File.join Configuration::MAIN_RESOURCES, 'META-INF'
      empty_directory metainf
      copy_file("orm/persistence.xml", (File.join metainf, "persistence.xml"))
    end
  end

  def create_webapp
    directory("webapp", Configuration::WEB_APP)
  end

  def create_javascripts
    create_file File.join @javascripts, "application.js"
  end

  def configure_scaffold_properties
    template("vraptor-scaffold.erb", Configuration::FILENAME)
  end

  def create_test
    empty_directory Configuration::TEST_SRC
    test_src = File.join(Configuration::TEST_SRC, options[:package].gsub(".", File::Separator))
    empty_directory File.join test_src, options[:controllers_package]
    empty_directory File.join test_src, options[:models_package]
    empty_directory File.join test_src, options[:repositories_package]
    directory("resources-test", Configuration::TEST_RESOURCES)
  end

  def create_jquery_files
    copy_file("jquery/jquery.min.js", "#{@javascripts}/jquery.min.js")
  end

  def create_bootstrap_files
    empty_directory @img
    copy_file("bootstrap/bootstrap.js", "#{@javascripts}/bootstrap.js")
    copy_file("bootstrap/bootstrap.css", "#{@stylesheets}/bootstrap.css")
    copy_file("bootstrap/bootstrap-responsive.css", "#{@stylesheets}/bootstrap-responsive.css")
    copy_file("bootstrap/glyphicons-halflings-white.png", "#{@img}/glyphicons-halflings-white.png")
    copy_file("bootstrap/glyphicons-halflings.png", "#{@img}/glyphicons-halflings.png")
  end

  def create_angular_files
    copy_file("angular/angular.js", "#{@javascripts}/angular.js")
  end

  def create_underscore_files
    copy_file("underscore/underscore.min.js", "#{@javascripts}/underscore.min.js")
  end

  def create_frontend_directory
    empty_directory Configuration::FRONTEND
  end

  def create_eclipse_files
    template("eclipse/classpath.erb", ".classpath")
    template("eclipse/project.erb", ".project")
    directory("eclipse/settings", ".settings")
  end

  private
  def orm
      options[:orm]
  end

  def validate
    unless ORMS.include? orm
      puts "ORM #{orm} is not supported. The supported object-relational mapping are: #{ORMS.join(", ")}"
      Kernel::exit
    end

    if File.directory? project_path
      puts "The project #{project_path} already exist"
      Kernel::exit
    end
  end
end
