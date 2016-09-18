(function() {
  "use strict";

  angular.module("app").controller("cohortCitiesCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupCohortCityIndex = function(){
      $http.get('/cohort_cities.json').then(function(response){
        $scope.cohortCities = response.data;
      });  
    };

    window.scope = $scope;
  }]);

}());