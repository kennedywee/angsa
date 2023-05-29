module Angsa
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('templates', __dir__)

    def create_base_controller
      copy_file 'angsa_gridjs_controller.js', 'app/javascript/controllers/angsa_gridjs_controller.js'
    end
  end
end