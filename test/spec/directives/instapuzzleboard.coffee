'use strict'

describe 'Directive: instapuzzleBoard', () ->

  # load the directive's module
  beforeEach module 'instapuzzleWebApp', 'views/board.html'

  scope = {}

  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    scope.board =
      width: 10
      height: 10
      imageURL: 'http://placekitten.com/300/300.jpg'

  it 'should add board class', inject ($compile) ->
    element = angular.element '<div instapuzzle-board instapuzzle-board-model="board"></div>'
    element = $compile(element)(scope)
    scope.$digest()
    expect(element).toHaveClass('board')
