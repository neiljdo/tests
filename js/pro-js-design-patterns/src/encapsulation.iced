###* Fully exposed object ###
class Book
  constructor: (isbn, title, author) ->
    if not isbn?
      throw new Error 'Book requires an isbn.'

    [@isbn, @title, @author] = [isbn, title ? 'default title', author ? 'default author']

  display: ->


try
  book = new Book null, 'title', 'author'
  console.log book
catch error
  console.log error

book2 = new Book 'isbn', 'title', 'author'
console.log book2

book3 = new Book 'isbn2'
console.log book3



