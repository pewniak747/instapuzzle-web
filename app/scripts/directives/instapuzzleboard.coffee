'use strict'

angular.module('instapuzzleWebApp')
  .directive 'instapuzzleBoard', ->
    link = (scope, element, attrs) ->
      element.addClass('board')
    scope:
      board: '=instapuzzleBoardModel'
    templateUrl: 'views/board.html'
    link: link
