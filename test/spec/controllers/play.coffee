'use strict'

describe 'Controller: PlayCtrl', ->

  # load the controller's module
  beforeEach module 'instapuzzleWebApp'

  PlayCtrl = {}
  scope = {}

  # Initialize the controller and a mock scope
  beforeEach inject ($controller, $rootScope) ->
    scope = $rootScope.$new()
    PlayCtrl = $controller 'PlayCtrl', {
      $scope: scope
    }

  it 'has default state of logged-out', ->
    expect(scope.state).toBe('logged-out')

  describe 'changeNickname', ->

    it 'changes the state to logged in', ->
      scope.nickname = 'bob'
      scope.changeNickname()
      expect(scope.state).toBe('logged-in')

    it 'does not change the state if length of nickname is 0', ->
      scope.nickname = ''
      scope.changeNickname()
      expect(scope.state).toBe('logged-out')

