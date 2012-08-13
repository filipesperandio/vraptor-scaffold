class ScaffoldGenerator < VraptorScaffold::Base

    attr_accessor :generated_attributes
    argument :model
    argument :attributes, :type => :hash, :default => {}, :banner => "field:type field:type"


    def self.banner
        "vraptor scaffold #{self.arguments.map(&:usage).join(' ')}"
    end

    def initialize(args)
        super(args)
        @generated_attributes = []
        attributes.each { |field, type| 
            @generated_attributes << Attribute.new(field, type)
        }
    end

    def controller_generator
        ControllerGenerator.new(model, @generated_attributes).build
    end

    def model_generator
        ModelGenerator.new(model, @generated_attributes).build
    end

    def repository_generator
        RepositoryGenerator.new(model, @generated_attributes).build
    end

    def client_generator
        ClientGenerator.new(model, @generated_attributes).build
    end
end
