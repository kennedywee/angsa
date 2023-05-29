module Angsa
  class JsGenerator < Rails::Generators::Base
    desc 'Generate the stimulus controller based on the table setup.'
    source_root File.expand_path('templates', __dir__)
    argument :model, type: :string

    # main function to generate based on setup
    def generate_stimulus_controller
      angsa_class = "#{model}Angsa".constantize.new(nil)
      @columns = angsa_class.columns.map { |col| col[:name].to_s.capitalize }

      template 'angsa_stimulus_controller.js', File.join('app', 'javascript', 'controllers', "#{stimulus_controller_path}.js")
    end

    # make the class name
    def stimulus_controller_name
      stimulus_controller_path.classify
    end

    def angsa_api_url
      model_name
    end

    private
    
    # for the controller path
    def stimulus_controller_path
      "#{model.underscore}_angsa_controller"
    end

    # get the model name
    def model_name
      "#{model.downcase}"
    end
  end
end
