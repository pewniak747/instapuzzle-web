'use strict'

angular.module('instapuzzleWebApp')
  .controller 'PlayCtrl', ($scope, socket) ->

    players = {}
    $scope.board =
      image: {}
      width: 0
      height: 0
      pieces: []


    socket.forward(['player:joined', 'player:left', 'player:synced', 'player:login', 'board:synced', 'board:finished', 'reconnect'], $scope)

    $scope.$on 'socket:player:joined', (event, data) ->
      players[data.id] =
        id: data.id
        name: data.name

    $scope.$on 'socket:player:left', (event, data) ->
      delete players[data.id]

    $scope.$on 'socket:player:synced', (event, data) ->
      players = {}
      _.each data, (attributes) ->
        players[attributes.id] =
          id: attributes.id
          name: attributes.name
      $scope.players = players

    $scope.$on 'socket:player:login', (event, data) ->
      $scope.currentPlayerId = data.id
      $scope.state = 'logged-in'

    $scope.$on 'socket:board:finished', (event, data) ->
      $scope.boardState = 'finished'
      $scope.preview = false

    $scope.$on 'socket:board:synced', (event, data) ->
      if data.finished
        $scope.boardState = 'finished'
      else
        $scope.boardState = 'not-finished'

    $scope.$on 'socket:reconnect', ->
      socket.emit('player:join')

    $scope.playersCount = ->
      _.size(players)

    $scope.showPreview = ->
      if $scope.state == 'logged-in'
        $scope.preview = true

    $scope.hidePreview = ->
      $scope.preview = false

    $scope.players = players
    $scope.state = 'logged-out'
    $scope.boardState = 'not-finished'

    socket.emit('player:join')
    socket.emit('player:sync')
