// Generated by CoffeeScript 1.6.3
angular.module('AMail', ['AMail.controllers', 'AMail.directives']).config(function($routeProvider) {
  $routeProvider.when('/', {
    controller: 'ListController',
    templateUrl: '/templates/list.html'
  }).when('/view/:id', {
    controller: 'DetailController',
    templateUrl: '/templates/detail.html'
  }).otherwise({
    redirectTo: '/'
  });
});
