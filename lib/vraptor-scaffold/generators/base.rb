module VraptorScaffold
  class Base < Thor::Group
    include Thor::Actions
  end
end

require File.dirname(__FILE__) + '/app/app_generator'
require File.dirname(__FILE__) + '/app/dependency'
require File.dirname(__FILE__) + '/app/dependency_manager'
require File.dirname(__FILE__) + '/scaffold/attribute'
require File.dirname(__FILE__) + '/scaffold/scaffold_generator'
require File.dirname(__FILE__) + '/scaffold/base_scaffold'
require File.dirname(__FILE__) + '/scaffold/model_generator/model_generator'
require File.dirname(__FILE__) + '/scaffold/repository_generator/repository_generator'
require File.dirname(__FILE__) + '/scaffold/controller_generator/controller_generator'
require File.dirname(__FILE__) + '/scaffold/client_generator/client_generator'
