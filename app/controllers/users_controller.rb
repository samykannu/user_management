class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  def index
    @users = User.all
    length, page, search_query = pagination_params(params)
    @all_users = if search_query.present?
                    @users.where(["UPPER(first_name) LIKE ?", "%#{search_query.upcase}%"])
                  else
                    @users
                  end
    @users = @all_users.paginate(:page => page, :per_page => length)

    respond_to do |format|
      format.html # index.html.erb
      count = @all_users.count
      format.json { render json:  {
                      recordsTotal: count,
                      recordsFiltered: count,
                      data: @users.collect{|user|
                        {
                          
                            "First Name" => user.first_name,
                          
                            "Last Name" => user.last_name,
                          
                            "Email" => user.email,
                          
                          'Actions' => user.id
                        }
                      }
                    }.to_json
                  }
      format.js #index.js.erb
    end
  end

  # GET /users/1
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to users_url, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    @user.image = params[:image]
    if @user.update(user_params)
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  #insert methods
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params[:user][:role_ids] = params[:user][:role_ids].reject(&:blank?)
      params.require(:user).permit(:first_name, :last_name, :email, :image, role_ids: [])
    end
end
