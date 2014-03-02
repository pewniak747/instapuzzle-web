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
    socketHost = if window.location.host.match('localhost')
      "localhost:9001"
    else
      "murmuring-dusk-5737.herokuapp.com"
    socketIO = io.connect("ws://#{socketHost}")
    socketFactory(ioSocket: socketIO)
