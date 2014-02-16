'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope) ->
    $scope.board =
      imageURL: 'http://distilleryimage6.ak.instagram.com/6191e200971711e3bad01215527ad906_8.jpg'
      width: 4
      height: 4
      pieces: [
        index: 15,
        x: 0,
        y: 0
      ,
        index: 1,
        x: 1,
        y: 0
      ,
        index: 2,
        x: 2,
        y: 0
      ,
        index: 3,
        x: 3,
        y: 0
      ,
        index: 4,
        x: 0,
        y: 1
      ,
        index: 5,
        x: 1,
        y: 1
      ,
        index: 6,
        x: 2,
        y: 1
      ,
        index: 7,
        x: 3,
        y: 1
      ,
        index: 8,
        x: 0,
        y: 2
      ,
        index: 9,
        x: 1,
        y: 2
      ,
        index: 10,
        x: 2,
        y: 2
      ,
        index: 11,
        x: 3,
        y: 2
      ,
        index: 12,
        x: 0,
        y: 3
      ,
        index: 13,
        x: 1,
        y: 3
      ,
        index: 14,
        x: 2,
        y: 3
      ,
        index: 0,
        x: 3,
        y: 3
      ]
