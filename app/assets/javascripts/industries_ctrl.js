(function() {
  "use strict";

  angular.module("app").controller("industriesCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupIndustryIndex = function(){
      $http.get('/industries.json').then(function(response){
        $scope.industries = response.data;
      });  
    };

    window.scope = $scope;
  }]);

}());