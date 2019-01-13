class SensorReportsGenerator < Rails::Generators::NamedBase
  source_root File.expand_path('../templates', __FILE__)

  def create_routes

    route "get '#{name.underscore.pluralize}/:id/sensors' => '#{name.underscore.pluralize}#sensors'"

    template_file_name = "app/controllers/#{name.underscore.pluralize}_controller.rb"
    after_line = "#insert methods\n"
    content = "\tdef sensors\n\tend"
    inject_into_file template_file_name, content, after: after_line

    # content = "\n" + '@sensor_templates = Template.where("' + "'#{temp.id}' = ANY (" + '\"belongs\")")'
   #  inject_into_file template_file_name, after: "def sensors" do <<-RUBY
	  #    @sensor_templates = Template.where("' + "'#{temp.id}' = ANY (" + '\"belongs\")")
	  # RUBY
	  # end

	  templt = Template.where(name: name).first
		sensor_templates = Template.where("'#{templt.id}' = ANY (\"belongs\")")

    after_line = "def sensors\n"

    content = "\t\t@#{name.underscore} = #{name.constantize}.find(params[:id])
\t\t@#{name.underscore}_sensor_types = #{sensor_templates.pluck(:name)}\n"

		inject_into_file template_file_name, content, after: after_line  

		# inject_into_file template_file_name, after: after_line do <<-'RUBY'
		# 	@<%= name.underscore %> = <%= name.constantize %>.find(params[:id])
		#   @<%= name.underscore}_sensor_types %> = <%= sensor_templates %>.pluck(:name)
		# RUBY
		# end

    after_line = "return '' +\n"
		inject_into_file "app/views/#{name.underscore.pluralize}/index.html.erb", after: after_line do <<-'RUBY'
			'<a class="btn btn-sm btn-success" id="edit_person_btn" href="/buildings/' + row.Actions + '/sensors">Sensors</a>'+
		RUBY
		end


    template "sensors.html.erb", "app/views/#{name.underscore.pluralize}/sensors.html.erb"

  end

end