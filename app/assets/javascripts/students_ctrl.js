(function() {
  "use strict";

  angular.module("app").controller("studentsCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupStudentIndex = function(){
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
          }
        }
      });

     
    };

    window.scope = $scope;
  }]);

}());