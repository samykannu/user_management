class ApplicationController < ActionController::Base
	layout 'admin'

	def pagination_params(params)
    start = params[:start].to_i
    length = params[:length].to_i
    length = 10 if length == 0
    page = start == 0 ? 1 : (start / length + 1)

    search_query = params[:search] && params[:search][:value]
    [length, page, search_query]
  end
end
