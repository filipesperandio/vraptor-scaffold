class ClientGenerator < BaseScaffold
  
  def build
    define_source_paths
    @template_dir = "#{Configuration::FRONTEND}/#{model_parameter_name}/"  
    empty_directory @template_dir
    create_js("controller", "#{controller_class_name}")
    generate_html("list")
    generate_html("details")
    generate_html("form")
    update_index
  end
  
  def create_js(template_name, file_name=template_name)
    template("#{template_name}.erb", "#{Configuration::JAVASCRIPTS}/#{file_name}.js")
  end

  def generate_html(template_name)
      template("#{template_name}.erb", "#{@template_dir}/#{template_name}.html")
  end

  def update_index
      file = "#{Configuration::WEB_APP}/index.html"
      index_content = File.read(file)
      updated_content = index_content.gsub("NGAPP", "ng-app=\"#{class_name}Module\"") 
      updated_content = updated_content.gsub("CONTROLLER", "#{controller_class_name}.js")
      File.open(file, "w") { |file| file.puts updated_content }
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
