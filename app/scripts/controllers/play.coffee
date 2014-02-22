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

    socket.forward(['player:join', 'player:leave', 'player:sync'], $scope)

    $scope.$on 'socket:player:join', (event, data) ->
      players[data.id] =
        name: data.name

    $scope.$on 'socket:player:leave', (event, data) ->
      delete players[data.id]

    $scope.$on 'socket:player:sync', (event, data) ->
      players = {}
      _.each data, (attributes) ->
        players[attributes.id] =
          name: attributes.name

    $scope.playersCount = ->
      _.size(players)

    $scope.players = players
