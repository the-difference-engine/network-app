(function() {
  "use strict";

  angular.module("app").controller("positionTypesCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupPositionTypeIndex = function(){
      $http.get('/position_types.json').then(function(response){
        $scope.positionTypes = response.data;
      });  
    };

    window.scope = $scope;
  }]);

}());