(function() {
  "use strict";

  angular.module("app").controller("technologiesCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupTechIndex = function(){
      $http.get('/technologies.json').then(function(response){
        $scope.technologies = response.data;
      });  
    };

    window.scope = $scope;
  }]);

}());