(function() {
  "use strict";

  angular.module("app").controller("adminsCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupUserSearch = function(){
      $http.get('/api/v1/employers.json').then(function(response){
        $scope.employers = response.data;
      });

      $http.get('/api/v1/students.json').then(function(response){
        $scope.students = response.data;
      });

      $http.get('/api/v1/admins.json').then(function(response){
        $scope.admins = response.data;
      });
    };

    window.scope = $scope;
  }]);

}());