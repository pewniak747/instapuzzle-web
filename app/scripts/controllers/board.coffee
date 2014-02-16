'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope, socket) ->
    board =
      imageURL: 'http://distilleryimage6.ak.instagram.com/6191e200971711e3bad01215527ad906_8.jpg'
      width: 5
      height: 5
      pieces: []

    width = board.width
    height = board.height
    widths = _.range(0, width)
    heights = _.range(0, height)
    positions = _(heights).chain().map (y) ->
      _.map widths, (x)-> [x, y]
    .flatten(1).value()

    board.pieces = _.map positions, (position, index) -> { x: position[0], y: position[1], index: index }

    $scope.selectedIndex = null

    $scope.$on 'piece:selected', (event, index) ->
      if $scope.selectedIndex == null
        $scope.selectedIndex = index
      else if $scope.selectedIndex == index
        $scope.selectedIndex = null
      else
        selectedPiece = board.pieces[$scope.selectedIndex]
        newPiece = board.pieces[index]
        tmpX = selectedPiece.x
        tmpY = selectedPiece.y
        selectedPiece.x = newPiece.x
        selectedPiece.y = newPiece.y
        newPiece.x = tmpX
        newPiece.y = tmpY
        $scope.selectedIndex = null

    $scope.board = board

    setTimeout ->
      positions = _.shuffle(positions)
      _.each $scope.board.pieces, (piece, index)->
        piece.x = positions[index][0]
        piece.y = positions[index][1]
      $scope.$apply()
    , 3000
