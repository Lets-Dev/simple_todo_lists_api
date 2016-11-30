class TodoListItemsController < ApplicationController
  before_action :set_todo_list_item, only: [:show, :update, :destroy]

  # GET /todo_list_items
  def index
    @todo_list_items = TodoListItem.all

    render json: @todo_list_items
  end

  # GET /todo_list_items/1
  def show
    render json: @todo_list_item
  end

  # POST /todo_list_items
  def create
    @todo_list_item = TodoListItem.new(todo_list_item_params)

    if @todo_list_item.save
      render json: @todo_list_item, status: :created, location: @todo_list_item
    else
      render json: @todo_list_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /todo_list_items/1
  def update
    if @todo_list_item.update(todo_list_item_params)
      render json: @todo_list_item
    else
      render json: @todo_list_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /todo_list_items/1
  def destroy
    @todo_list_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_todo_list_item
      @todo_list_item = TodoListItem.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def todo_list_item_params
      params.require(:todo_list_item).permit(:label, :status, :todo_list_id)
    end
end
