###*
 * Fully exposed object
###
class Book1
  constructor: (isbn, title, author) ->
    if not isbn?
      throw new Error 'Book requires an isbn.'

    [@isbn, @title, @author] = [isbn, title ? 'No title specified.', author ? 'No author specified.']

  display: ->

try
  book = new Book1 null, 'title', 'author'
  console.log book
catch error
  console.log error

book2 = new Book1 'isbn', 'title', 'author'
console.log book2

book3 = new Book1 'isbn2'
console.log book3


###*
 * Stricter ISBN check
###
class Book2
  constructor: (isbn, title, author) ->
    throw new Error 'Book: Invalid ISBN' if !@checkIsbn isbn

    [@isbn, @title, @author] = [
      isbn,
      title ? 'No title specified.',
      author ? 'No author specified.'
    ]

  checkIsbn: (isbn) -> false

try
  book = new Book2 'natehu'
  console.log book
catch error
  console.log error


###*
 * With getter and setter
###
class Book3
  constructor: (isbn, title, author) ->
    @setIsbn isbn
    @setTitle title
    @setAuthor author

  getIsbn: -> @isbn
  getTitle: -> @title
  getAuthor: -> @author

  checkIsbn: (isbn) -> true
  setIsbn: (isbn) ->
    throw new Error 'Book: Invalid ISBN' if !@checkIsbn isbn
    @isbn = isbn

  setTitle: (title) -> @title = title ? 'No title specified.'
  setAuthor: (author) -> @author = author ? 'No author specified.'

try
  book = new Book3 'weeee~'
  console.log book
catch error
  console.log error
