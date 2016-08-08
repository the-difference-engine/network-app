(function() {
  "use strict";

  angular.module("app").controller("salaryRangesCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupSalaryRangeIndex = function(){
      $http.get('/salary_ranges.json').then(function(response){
        $scope.salaryRanges = response.data;
      });  
    };

    window.scope = $scope;
  }]);

}());