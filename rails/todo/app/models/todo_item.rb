class TodoItem < ActiveRecord::Base
  attr_accessible :completed, :title
end
