class Api::V1::<%= class_name.pluralize %>Controller < Api::V1::BaseController
	def create
    <%= file_name.gsub("_value", "") %> = <%= class_name.gsub("Value", "") %>.where(device_id: params[:device_id]).first
    if !<%= file_name.gsub("_value", "") %>
      value_params = <%= class_name %>.new.attributes.inject({}){ |acc, v| 
        acc.merge!({v[0] => params[v[0]]}) if !["id", "created_at", "updated_at"].include?(v[0])
        acc
      }

      <%= class_name %>.new(value_params).save
      render json: {status: 200, message: 'Finished'}
    else
      render json: {status: 500, message: 'Device not found'}
    end  
  end
  
end
