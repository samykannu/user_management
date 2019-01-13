class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  # GET /roles
  def index
    @roles = Role.all
    length, page, search_query = pagination_params(params)
    @all_roles = if search_query.present?
                    @roles.where(["UPPER(name) LIKE ?", "%#{search_query.upcase}%"])
                  else
                    @roles
                  end
    @roles = @all_roles.paginate(:page => page, :per_page => length)

    respond_to do |format|
      format.html # index.html.erb
      count = @all_roles.count
      format.json { render json:  {
                      recordsTotal: count,
                      recordsFiltered: count,
                      data: @roles.collect{|role|
                        {
                          
                            "Name" => role.name,
                          
                            "Status" => role.status,
                          
                          'Actions' => role.id
                        }
                      }
                    }.to_json
                  }
      format.js #index.js.erb
    end
  end

  # GET /roles/1
  def show
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
  end

  # POST /roles
  def create
    @role = Role.new(role_params)

    if @role.save
      redirect_to roles_url, notice: 'Role was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /roles/1
  def update
    if @role.update(role_params)
      redirect_to roles_url, notice: 'Role was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /roles/1
  def destroy
    @role.destroy
    redirect_to roles_url, notice: 'Role was successfully destroyed.'
  end

  def hide_roles
    @roles = Role.order("name")
  end

  def post_hide_roles
    params[:role].keys.each do |role_id|
      if params[:role][role_id]["status"] == "1"
        role = Role.find(role_id)
        role.status = role.status == "Active" ? "In-Active" : "Active"
        role.save
      end
    end
    redirect_to roles_path
  end

  #insert methods
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_role
      @role = Role.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def role_params
      params.require(:role).permit(:name, :status)
    end
end
