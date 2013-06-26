angular
  .module('AMail', ['AMail.controllers', 'AMail.directives'])
  .config(
    ($routeProvider) ->
      $routeProvider
        .when('/', {
          controller: 'ListController',
          templateUrl: '/templates/list.html'
        })
        .when('/view/:id', {
          controller: 'DetailController',
          templateUrl: '/templates/detail.html'
        })
        .otherwise({
          redirectTo: '/'
        })

      return
  )
