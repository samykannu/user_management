class ReferencesGenerator < Rails::Generators::Base
  def create_references
  	Template.order("id").each{|template|
  		template_file_name = "app/models/#{template.name.underscore}.rb"
  		template_file_name_pluralize = template.name.underscore.pluralize
      template_file_name_assoc = template.name.underscore

  		template_ids = template.belongs
  		templates = Template.where(id: template_ids).each{|temp|
      	temp_file_name = "app/models/#{temp.name.underscore}.rb"
      	after_line = "class #{temp.name} < ApplicationRecord\n"
      	content = "\thas_many :#{template_file_name_pluralize}, dependent: :destroy\n"
        puts [temp_file_name, content, after: after_line].inspect
      	inject_into_file temp_file_name, content, after: after_line
			}

      template_ids = template.sensors
      templates = Template.where(id: template_ids).each{|temp|
        temp_file_name = "app/models/#{temp.name.underscore}.rb"
        after_line = "class #{temp.name} < ApplicationRecord\n"
        content = "\thas_many :#{template_file_name_pluralize}, dependent: :destroy \n
        \thas_many :#{template_file_name_assoc}_dailies, dependent: :destroy \n
        \thas_many :#{template_file_name_assoc}_weeks, dependent: :destroy\n
        \thas_many :#{template_file_name_assoc}_months, dependent: :destroy\n"

        puts [temp_file_name, content, after: after_line].inspect
        inject_into_file temp_file_name, content, after: after_line
      }

      if template.template_type == "Belong" || (template.template_type == "Sensor" && template.table_for == "Onboard")
        temp_file_name = "app/views/layouts/_admin_sidebar_menu.html.erb"
        after_line = "<!-- insert belongs link -->"
        content = "\n\t\t\t<li>\n\t\t\t\t<a href='/#{template.name.underscore.pluralize}'><i class='fa fa-cogs fa-fw'></i>#{template.name.pluralize}</a>\n\t\t\t</li>"
        inject_into_file temp_file_name, content, after: after_line
      end
  	}
  end
end