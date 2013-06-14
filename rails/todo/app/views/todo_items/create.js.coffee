$('.new-todo').val ''
html = "<%= escape_javascript(render partial: 'todo_item', locals: {item: @todo_item}) %>"
$('.todo-list').append html