(function() {
  "use strict";

  angular.module("app").controller("positionsCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupPositionIndex = function(){
      $http.get('/positions.json').then(function(response){
        $scope.positions = response.data;
      });  
    };

    window.scope = $scope;
  }]);

}());