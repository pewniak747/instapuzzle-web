'use strict'

angular.module('instapuzzleWebApp')
  .controller 'PlayCtrl', ($scope, storage) ->

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
