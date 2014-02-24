'use strict'

angular.module('instapuzzleWebApp')
  .controller 'PlayCtrl', ($scope, storage, socket) ->

    $scope.changeNickname = ->
      if @nickname?.length
        $scope.nickname = @nickname
        $scope.state = 'logged-in'
        storage.set('nickname', @nickname)
      else
        $scope.state = 'logged-out'
        storage.remove('nickname')

    $scope.resetNickname = ->
      $scope.nickname = undefined
      $scope.changeNickname()

    $scope.nickname = storage.get('nickname')
    $scope.changeNickname()

    players = {}

    socket.forward(['player:joined', 'player:left', 'player:synced'], $scope)

    $scope.$on 'socket:player:joined', (event, data) ->
      players[data.id] =
        name: data.name

    $scope.$on 'socket:player:left', (event, data) ->
      delete players[data.id]

    $scope.$on 'socket:player:synced', (event, data) ->
      players = {}
      _.each data, (attributes) ->
        players[attributes.id] =
          name: attributes.name
      $scope.players = players

    $scope.playersCount = ->
      _.size(players)

    $scope.players = players

    socket.emit('player:join')
    socket.emit('player:sync')
