'use strict'

describe 'Controller: PlayCtrl', ->

  # load the controller's module
  beforeEach module('instapuzzleWebApp')

  PlayCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope, socket) ->
    scope = $rootScope.$new()
    PlayCtrl = $controller 'PlayCtrl', {
      $scope: scope
      socket: socket
    }
