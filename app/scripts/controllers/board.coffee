'use strict'

angular.module('instapuzzleWebApp')
  .controller 'BoardCtrl', ($scope, socket) ->
    $scope.selectedId = null

    $scope.$on 'piece:selected', (event, args) ->
      if $scope.selectedId == null
        socket.emit('piece:pickup', args.id)
      else
        socket.emit('piece:move', id: $scope.selectedId, x: args.x, y: args.y)
        $scope.$emit('piece:moved')

    socket.forward(['piece:picked', 'piece:moved', 'piece:correct', 'board:synced'], $scope)

    findPieceById = (id) ->
      _.find $scope.board.pieces, (piece) -> piece.id == id

    $scope.$on 'socket:piece:picked', (event, args) ->
      piece = findPieceById(args.piece_id)
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
      piece = findPieceById(args.piece_id)
      if piece?
        piece.x = args.position.x
        piece.y = args.position.y
        piece.holder = null
        $scope.selectedId = null

    $scope.$on 'socket:piece:correct', (event, args) ->
      piece = findPieceById(args.piece_id)
      piece?.correct = true

    socket.emit('board:sync')
