'use strict'

angular.module('instapuzzleWebApp')
  .controller 'PlayCtrl', ($scope) ->
    $scope.state = 'logged-out'

    $scope.changeNickname = ->
      if @nickname?.length
        $scope.state = 'logged-in'
