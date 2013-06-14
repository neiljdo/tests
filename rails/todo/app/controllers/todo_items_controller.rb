class TodoItemsController < ApplicationController
    def index
        @todo_items = TodoItem.all
    end

    def create
        @todo_item = TodoItem.create(params[:todo_item])
    end

    def update
        item = TodoItem.find params[:id]
        item.update_attributes params[:todo_item]
        render nothing: true
    end

    def destroy
        TodoItem.find(params[:id]).destroy
        render nothing: true
    end
end
