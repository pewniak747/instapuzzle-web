'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope, socket) ->
    board =
      imageURL: ''
      width: 0
      height: 0
      pieces: []

    $scope.selectedId = null

    $scope.$on 'piece:selected', (event, args) ->
      if $scope.selectedId == null
        socket.emit('piece:pickup', args.id)
        $scope.selectedId = args.id
      else
        socket.emit('piece:move', id: $scope.selectedId, x: args.x, y: args.y)
        $scope.selectedId = null

    $scope.board = board

    socket.forward(['piece:picked', 'piece:moved', 'board:synced'], $scope)

    $scope.$on 'socket:piece:picked', (event, args) ->
      piece = _.find $scope.board.pieces, (piece) -> piece.id == args.piece_id
      piece?.selected = true

    $scope.$on 'socket:board:synced', (event, args) ->
      $scope.board.imageURL = args.imageURL
      $scope.board.width = args.width
      $scope.board.height = args.height
      $scope.board.pieces = _.map args.pieces, (piece, index) ->
        piece.index = index
        piece

    $scope.$on 'socket:piece:moved', (event, args) ->
      piece = _.find $scope.board.pieces, (piece) -> piece.id == args.piece_id
      piece?.x = args.position.x
      piece?.y = args.position.y
      piece?.selected = false

    socket.emit('board:sync')
