'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope) ->
    $scope.board =
      imageURL: 'http://distilleryimage6.ak.instagram.com/6191e200971711e3bad01215527ad906_8.jpg'
      width: 5
      height: 5
      pieces: []

    width = $scope.board.width
    height = $scope.board.height
    widths = _.range(0, width)
    heights = _.range(0, height)
    positions = _(heights).chain().map (y) ->
      _.map widths, (x)-> [x, y]
    .flatten(1).value()

    $scope.board.pieces = _.map positions, (position, index) -> { x: position[0], y: position[1], index: index }

    setInterval ->
      positions = _.shuffle(positions)
      _.each $scope.board.pieces, (piece, index)->
        piece.x = positions[index][0]
        piece.y = positions[index][1]
      $scope.$apply()
    , 3000
