WorkLogger = angular.module 'WorkLogger', ['ngCookies']

WorkLogger.config ($interpolateProvider) ->
  $interpolateProvider
    .startSymbol('{[')
    .endSymbol(']}')

WorkLogger.controller 'WorkLoggerCtrl', ($scope, $cookies, $filter, $http) ->
  getProjectName = (entry) ->
    $http.get(entry.project).success (data, status, headers, config) ->
      entry.projectName = data.name

  updatePage = (formattedDate) ->
    $http.get("/api/v1/logentry/?format=json&date=#{ formattedDate }").success (data, status, headers, config) ->
      $scope.current_user = data.current_user
      $scope.viewed_date = $filter('date') data.viewed_date, 'yyyy-MM-dd'

      getProjectName(e) for e in data.objects
      $scope.entries = data.objects

      $scope.daily_total = data.daily_total
      $scope.weekly_total = data.weekly_total
      $scope.monthly_total = data.monthly_total

      # update createLogEntryForm
      $scope.date = $scope.viewed_date
      $scope.duration = 0.0
      $http.get("/api/v1/project/?format=json&members=#{ $scope.current_user.pk }").success (data, status, headers, config) ->
        $scope.projects = data.objects

  $scope.init = ->
    current_date = new Date()
    date_created = $filter('date') current_date.valueOf(), 'yyyy-MM-dd'
    updatePage date_created

  $scope.viewDate = ->
    updatePage $scope.viewed_date

  $scope.createLogEntry = ->
    $http.defaults.headers.post['X-CSRFToken'] = $cookies.csrftoken

    $http.post("/api/v1/logentry/", {
        user: "/api/v1/user/#{ $scope.current_user.pk }/"
        date: $scope.date
        duration: $scope.duration
        project: $scope.project
        remarks: $scope.remarks
      }).success (data, status, headers, config) ->
        updatePage $scope.viewed_date



