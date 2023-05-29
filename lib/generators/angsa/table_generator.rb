module Angsa
  class TableGenerator < Rails::Generators::Base
    desc 'Generate table setup for a model'
    source_root File.expand_path('templates', __dir__)
    argument :model, type: :string

    def generate_table_setup
      template 'table_setup.rb', File.join('app', 'angsa', "#{setup_table_path}.rb")
    end

    private
    def setup_table_path
      "#{model.downcase}_angsa"
    end

    def model_class_name
      "#{model.classify}Angsa"
    end

    def model_name
      "#{model}"
    end
  end
end