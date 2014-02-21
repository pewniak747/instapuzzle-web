'use strict'

angular.module('instapuzzleWebApp', [
  'ngCookies',
  'ngResource',
  'ngSanitize',
  'ngRoute',
  'angularLocalStorage',
  'btford.socket-io'
])
  .config ($routeProvider) ->
    $routeProvider.when('/', {
        templateUrl: 'views/main.html',
        controller: 'MainCtrl'
      })
      .otherwise({
        redirectTo: '/'
      })
  .factory 'socket', (socketFactory) ->
    socketIO = io.connect('ws://localhost:9001')
    socketFactory(ioSocket: socketIO)
