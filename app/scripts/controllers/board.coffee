'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope, socket) ->
    $scope.selectedId = null

    $scope.$on 'piece:selected', (event, args) ->
      if $scope.selectedId == null
        socket.emit('piece:pickup', args.id)
      else
        socket.emit('piece:move', id: $scope.selectedId, x: args.x, y: args.y)

    socket.forward(['piece:picked', 'piece:moved', 'board:synced'], $scope)

    $scope.$on 'socket:piece:picked', (event, args) ->
      piece = _.find $scope.board.pieces, (piece) -> piece.id == args.piece_id
      holder = $scope.players[args.player_id] || {}
      piece?.holder = holder
      $scope.selectedId = piece?.id

    $scope.$on 'socket:board:synced', (event, args) ->
      $scope.board.image = args.image
      $scope.board.width = args.width
      $scope.board.height = args.height
      $scope.board.pieces = _.map args.pieces, (piece, index) ->
        piece.index = index
        piece

    $scope.$on 'socket:piece:moved', (event, args) ->
      piece = _.find $scope.board.pieces, (piece) -> piece.id == args.piece_id
      if piece?
        piece.x = args.position.x
        piece.y = args.position.y
        piece.holder = null
        $scope.selectedId = null

    socket.emit('board:sync')
