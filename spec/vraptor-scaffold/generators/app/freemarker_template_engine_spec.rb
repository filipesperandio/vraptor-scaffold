require File.expand_path(File.dirname(__FILE__) + "/../../../spec_helper")

describe FreemarkerTemplateEngine do

  before(:all) do
    @project_path = "src/vraptor-scaffold"
    @webapp = "#{@project_path}/#{Configuration::WEB_APP}"
    @web_inf = "#{@project_path}/#{Configuration::WEB_INF}"
    @decorators = "#{@web_inf}/views/decorators"
    @app = "#{@project_path}/#{Configuration::MAIN_SRC}/br/com/caelum"
  end

  context "configuring" do
    before(:all) do
      AppGenerator.new(@project_path, ["--template-engine=ftl", "-p=br.com.caelum", "--orm=hibernate"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should create decorators.xml" do
      source = File.join File.dirname(__FILE__), "templates", "decorators.xml"
      destination = "#{@web_inf}/decorators.xml"
      exists_and_identical?(source, destination)
    end

    it "should create web.xml" do
      source = File.join File.dirname(__FILE__), "templates", "freemarker-web.xml"
      destination = "#{@web_inf}/web.xml"
      exists_and_identical?(source, destination)
    end

    it "should create views folder" do
      File.exist?("#{@web_inf}/views").should be_true 
    end

    it "should create infrastructure folder" do
      File.exist?("#{@app}/infrastructure").should be_true 
    end

    it "should create path resolver" do
      source = File.join File.dirname(__FILE__), "templates", "FreemarkerPathResolver.java"
      destination = "#{@app}/infrastructure/FreemarkerPathResolver.java"
      exists_and_identical?(source, destination)
    end

    it "should create decorator file" do
      destination = "#{@decorators}/main.ftl"
      content = File.read(destination)
      content.include?("bootstrap").should be_false
      content.empty?.should be_false
    end

    it "should create html macro file" do
      source = "#{FreemarkerTemplateEngine.source_root}/macros/html.ftl"
      destination = "#{@webapp}/macros/html.ftl"
      exists_and_identical?(source, destination)
    end
  end

  context "bootstrap setup" do
    before(:all) do
      AppGenerator.new(@project_path, ["--template-engine=ftl", "--bootstrap"]).invoke_all
    end

    after(:all) do
      FileUtils.remove_dir(@project_path)
    end

    it "should add bootstrap js and css" do
      main = "#{@decorators}/main.ftl"
      js_added = '<@html.js "bootstrap"/>'
      css_added = '<@html.css "bootstrap"/>'
      content = File.read(main)
      content.include?(js_added).should be_true
      content.include?(css_added).should be_true
    end
  end
end
