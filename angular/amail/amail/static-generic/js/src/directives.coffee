angular
  .module('AMail.directives', [])
  .directive(
    'ngbkFocus', ->
      link: (scope, element, attrs, controller) ->
        element[0].focus()
        return
  )
