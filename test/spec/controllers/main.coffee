'use strict'

describe 'Controller: MainCtrl', ->

  # load the controller's module
  beforeEach(module('instapuzzleWebApp'))

  MainCtrl = null
  scope = null

  # Initialize the controller and a mock scope
  beforeEach inject(($controller, $rootScope) ->
    scope = $rootScope.$new()
    MainCtrl = $controller('MainCtrl',
      $scope: scope
    )
  )

  it 'sets currentTab to play by default', ->
    expect(scope.currentTab).toBe('play')

  describe 'switchTab', ->

    it 'sets currentTab to about', ->
      scope.switchTab('about')
      expect(scope.currentTab).toBe('about')

  describe 'isCurrentTab', ->

    beforeEach ->
      scope.currentTab = 'play'

    it 'is true if is current tab', ->
      expect(scope.isCurrentTab('play')).toBe(true)

    it 'is false if is not current tab', ->
      expect(scope.isCurrentTab('about')).toBe(false)
