'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope) ->
    $scope.board =
      imageURL: 'http://distilleryimage6.ak.instagram.com/6191e200971711e3bad01215527ad906_8.jpg'
      width: 10
      height: 10
