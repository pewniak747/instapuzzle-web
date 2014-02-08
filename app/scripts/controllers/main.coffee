'use strict'

angular.module('instapuzzleWebApp')
  .controller 'MainCtrl', ($scope) ->
    $scope.currentTab = 'play'

    $scope.switchTab = (tab)->
      $scope.currentTab = tab

    $scope.isCurrentTab = (tab) ->
      $scope.currentTab == tab
