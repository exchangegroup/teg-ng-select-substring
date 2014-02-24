angular.module('TegTestApp', ['TegNgSelectSubstring']).
controller('tegTestAppController', function($scope, tegNgSelectSubstring) {
  $scope.text = 'Gray caterpillar & gray cat on a pillar'
  $scope.textToHighlight = 'cat pillar'
  $scope.tegNgSelectSubstring = tegNgSelectSubstring
});