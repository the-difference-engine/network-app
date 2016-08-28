(function() {
  "use strict";

  angular.module("app").controller("adminsCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupDash = function(){
      $scope.pendingUsers = [];

      $http.get('/api/v1/employers.json').then(function(response){
        $scope.employers = response.data;
        $scope.activeEmployers = [];
        $scope.pendingEmployers = [];

        for(var i = 0; i < $scope.employers.length; i++){
          var employer = $scope.employers[i];
          if(employer.active){
            $scope.activeEmployers.push(employer);
          } else  {
            $scope.pendingEmployers.push(employer);
            $scope.pendingUsers.push(employer);
          }
        }
      });

      $http.get('/api/v1/students.json').then(function(response){
        $scope.students = response.data;
        $scope.activeStudents = [];
        $scope.pendingStudents = [];

        for(var i = 0; i < $scope.students.length; i++){
          var student = $scope.students[i];
          if(student.active){
            $scope.activeStudents.push(student);
          } else  {
            $scope.pendingStudents.push(student);
            $scope.pendingUsers.push(student);
          }
        }
      });

      $http.get('/api/v1/admins.json').then(function(response){
        $scope.admins = response.data;
        $scope.activeAdmins = [];
        $scope.pendingAdmins = [];

        for(var i = 0; i < $scope.admins.length; i++){
          var admin = $scope.admins[i];
          if(admin.active){
            $scope.activeAdmins.push(admin);
          } else  {
            $scope.pendingAdmins.push(admin);
            $scope.pendingUsers.push(admin);
          }
        }
      });      
    };

    window.scope = $scope;
  }]);

}());