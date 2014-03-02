'use strict'

angular.module('instapuzzleWebApp')
  .directive 'instapuzzleBoard', ->
    link = (scope, element, attrs) ->
      board = scope.board
      element.addClass('board')
      element.css('height': element.width())
    scope:
      board: '=instapuzzleBoardModel'
    controller: ($scope) ->
      $scope.pieceSelected = (index, piece) ->
        $scope.$emit('piece:selected', piece)
    templateUrl: 'views/board.html'
    link: link

  .directive 'instapuzzlePiece', ->
    link = (scope, element, attrs) ->
      board = scope.board
      piece = scope.piece
      width = 100.0 / board.width
      height = 100.0 / board.height
      backgroundPositions = piece.id.split(":")[0...2]
      x = parseInt(backgroundPositions[0], 10)
      y = parseInt(backgroundPositions[1], 10)
      backgroundPosX = (100.0 / (board.width - 1)) * x
      backgroundPosY = (100.0 / (board.height - 1)) * y
      element.css
        width: "#{width}%"
        height: "#{height}%"
        'background-image': "url('#{board.imageURL}')"
        'background-position': "#{backgroundPosX}% #{backgroundPosY}%"
        'background-size': "#{board.width * 100}% #{board.height * 100}%"

      positionX = (pieceX)->
        x = piece.index % board.width
        (100.0 / board.width) * (pieceX - x)

      positionY = (pieceY)->
        y = Math.floor(piece.index / board.height)
        (100.0 / board.height) * (pieceY - y)

      scope.$watchCollection '[piece.x, piece.y]', (position) ->
        element.animate
          left: "#{positionX(position[0])}%"
          top: "#{positionY(position[1])}%"
        , -> element.removeClass('is-selected')

      scope.$watch 'piece.selected', (value) ->
        element.toggleClass('is-selected', !!value)

    scope:
      piece: '=instapuzzleBoardPiece'
      board: '=instapuzzleBoardModel'
    link: link
