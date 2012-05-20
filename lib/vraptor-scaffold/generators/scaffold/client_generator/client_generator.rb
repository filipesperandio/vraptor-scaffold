class ClientGenerator < BaseScaffold
  
  def build
    define_source_paths
    create_js("controller", "#{controller_class_name}")
    create_js("model", "#{class_name}")
  end
  
  def create_js(template_name, file_name=template_name)
    template("#{template_name}.erb", "#{Configuration::JAVASCRIPTS}/#{file_name}.js")
  end

  def template_path
    "src/templates/client"
  end
  
  def source_root
    File.join File.dirname(__FILE__), "templates"
  end

  def path
    "/#{base_path}"
  end
end
