'use strict'

describe 'Controller: BoardCtrl', () ->

  # load the controller's module
  beforeEach module 'instapuzzleWebApp'

  BoardCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    BoardCtrl = $controller 'BoardCtrl', {
      $scope: scope
    }
