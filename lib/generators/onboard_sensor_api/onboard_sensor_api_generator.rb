class OnboardSensorApiGenerator < Rails::Generators::NamedBase
  source_root File.expand_path("../templates", __FILE__)

  def create_api
    template "onboard_sensor_api.rb", "app/controllers/api/v1/#{file_name.pluralize}_controller.rb"
    inject_into_file 'config/routes.rb', "\n\t\t\tresources :#{file_name.pluralize}", { after: "namespace :v1 do", verbose: false }
  end 

end