namespace :run_scaffold do
  desc "Run RunScaffold"

  task belong: :environment do
    data_types = {"text" => "string", "number" => "float", "date" => "date", "time" => "time", "paragraph"  => "text"}
    Template.where(template_type: "Belong").order(:id).each{|template|
      data = template.data
      class_name = template.name.remove(" ").classify
      columns = []
      data.values.each{|column|
        columns << "#{ column["name"].remove(" ").underscore }:#{ data_types[column["type"]] }"
      }
      puts "rails generate scaffold #{ class_name } #{ columns.join(" ") }"
      system("rails generate scaffold #{class_name} #{ columns.join(" ") }")
    }
    # sleep 2
    # system("rake db:migrate")
  end

  task sensor: :environment do
    commands = []
    data_types = {"text" => "string", "number" => "float", "date" => "date", "time" => "time", "paragraph"  => "text"}
    Template.where(template_type: "Sensor").order(:id).each{|template|
      data = template.data
      class_name = template.name.remove(" ").classify
      columns = []
      data.values.each{|column|
        columns << "#{ column["name"].remove(" ").underscore }:#{ data_types[column["type"]] }"
      }
      template_ids = template.belongs
      template_ids = template.sensors if !template_ids.present?
      Template.where(id: template_ids).each{|temp|
        columns << "#{ temp.name.underscore }:references"
      }
      commands << "rails generate scaffold #{class_name} #{ columns.join(" ") }"

      if template.template_type == "Sensor"
        if template.table_for == "Data"
          commands << "rails generate sensor_api #{class_name}"
        elsif template.table_for == "Onboard"
          commands << "rails generate onboard_sensor_api #{class_name}"
        end
      end

      if template.template_type == "Sensor" && template.table_for == "Data"
        daily_columns = ["summary_for:date"]
        monthly_columns = ["month_number:integer", "year:integer"]

        commands << "rails generate model #{class_name}Daily #{ (columns + daily_columns).join(" ") }"

        commands << "rails generate model #{class_name}Week #{ columns.join(" ") }"

        commands << "rails generate model #{class_name}Month #{ (columns + monthly_columns).join(" ") }"

        columns = data.values.collect{|column| "#{ column["name"].downcase }:#{ data_types[column["type"]] }"}
        columns << "#{class_name.underscore}:references"
        
        commands << "rails generate model Calculated#{class_name} #{ columns.join(" ") }"

        commands << "rails generate model Calculated#{class_name}Daily #{ (columns + daily_columns).join(" ") }"

        commands <<"rails generate model Calculated#{class_name}Week #{ columns.join(" ") }"

        commands << "rails generate model Calculated#{class_name}Month #{ (columns + monthly_columns).join(" ") }"
      end

      sensor_table = SensorTable.new(name: class_name, template_type: template.template_type, table_for: template.table_for)
      sensor_table.save

      data.values.each{|column| 
        column_detail = sensor_table.column_details.new(mname: class_name, cname: column["name"].downcase, actual_cname: column["name"].downcase)
        if data_types[column["type"]] == "float" && column["units"].present?
          column_detail.unit = column["units"]
          column_detail.calculated_unit = column["units"]
        end
        column_detail.save
        puts column_detail.attributes.inspect
      }

    }

    commands.each{|command|
      puts command
      system(command)
    }

    puts commands.inspect
    
    # sleep 2
    # system("rake db:migrate")
  end

  task build_association: :environment do
    puts "rails generate references"
    system("rails generate references")
  end

  task list_sensors: :environment do
    Template.where(template_type: "Belong").each do |template|
      system("rails generate sensor_reports #{template.name}")
    end
  end

  task create_sensor_table_entries: :environment do
    data_types = {"text" => "string", "number" => "float", "date" => "date", "time" => "time", "paragraph"  => "text"}
    Template.order(:id).each{|template|
      class_name = template.name.remove(" ").classify
      sensor_table = SensorTable.new(name: class_name, template_type: template.template_type, table_for: template.table_for)
      sensor_table.save

      template.data.values.each{|column| 
        column_detail = sensor_table.column_details.new(mname: class_name, cname: column["name"].downcase, actual_cname: column["name"].downcase)
        if data_types[column["type"]] == "float" && column["units"].present?
          column_detail.unit = column["units"]
          column_detail.calculated_unit = column["units"]
        end
        column_detail.save
      }
    }
  end
end 