'use strict'

angular.module('instapuzzleWebApp')
  .directive 'instapuzzleBoard', ->
    link = (scope, element, attrs) ->
      board = scope.board
      element.addClass('board')
      element.css('height': element.width())
    scope:
      board: '=instapuzzleBoardModel'
    templateUrl: 'views/board.html'
    link: link

  .directive 'instapuzzlePiece', ->
    link = (scope, element, attrs) ->
      board = scope.board
      width = 100.0 / board.width
      height = 100.0 / board.height
      posX = (100.0 / (board.width - 1)) * scope.piece.x
      posY = (100.0 / (board.height - 1)) * scope.piece.y
      element.css(
        width: "#{width}%"
        height: "#{height}%"
        'background-image': "url('#{board.imageURL}')"
        'background-position': "#{posX}% #{posY}%"
        'background-size': "#{board.width * 100}% #{board.height * 100}%"
      )
    scope:
      piece: '=instapuzzleBoardPiece'
      board: '=instapuzzleBoardModel'
    link: link
