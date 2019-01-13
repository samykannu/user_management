class UserDynamicColumnsController < ApplicationController
  before_action :set_user_dynamic_column, only: [:show, :edit, :update, :destroy]

  # GET /user_dynamic_columns
  def index
    @user_dynamic_columns = UserDynamicColumn.all
    length, page, search_query = pagination_params(params)
    @all_user_dynamic_columns = if search_query.present?
                    @user_dynamic_columns.where(["UPPER(meta_key) LIKE ?", "%#{search_query.upcase}%"])
                  else
                    @user_dynamic_columns
                  end
    @user_dynamic_columns = @all_user_dynamic_columns.paginate(:page => page, :per_page => length)

    respond_to do |format|
      format.html # index.html.erb
      count = @all_user_dynamic_columns.count
      format.json { render json:  {
                      recordsTotal: count,
                      recordsFiltered: count,
                      data: @user_dynamic_columns.collect{|user_dynamic_column|
                        {
                          
                            ColumnDetail.display_column_name('UserDynamicColumn', 'meta_key') => user_dynamic_column.meta_key,
                          
                            ColumnDetail.display_column_name('UserDynamicColumn', 'meta_value') => user_dynamic_column.meta_value,
                          
                            ColumnDetail.display_column_name('UserDynamicColumn', 'user_id') => user_dynamic_column.user_id,
                          
                          'Actions' => user_dynamic_column.id
                        }
                      }
                    }.to_json
                  }
      format.js #index.js.erb
    end
  end

  # GET /user_dynamic_columns/1
  def show
  end

  # GET /user_dynamic_columns/new
  def new
    @user_dynamic_column = UserDynamicColumn.new
  end

  # GET /user_dynamic_columns/1/edit
  def edit
  end

  # POST /user_dynamic_columns
  def create
    @user_dynamic_column = UserDynamicColumn.new(user_dynamic_column_params)

    if @user_dynamic_column.save
      redirect_to user_dynamic_columns_url, notice: 'User dynamic column was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /user_dynamic_columns/1
  def update
    if @user_dynamic_column.update(user_dynamic_column_params)
      redirect_to user_dynamic_columns_url, notice: 'User dynamic column was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /user_dynamic_columns/1
  def destroy
    @user_dynamic_column.destroy
    redirect_to user_dynamic_columns_url, notice: 'User dynamic column was successfully destroyed.'
  end

  #insert methods
  

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_dynamic_column
      @user_dynamic_column = UserDynamicColumn.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_dynamic_column_params
      params.require(:user_dynamic_column).permit(:meta_key, :meta_value, :user_id)
    end
end
