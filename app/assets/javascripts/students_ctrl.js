(function() {
  "use strict";

  angular.module("app").controller("studentsCtrl", ['$scope', '$http', function($scope, $http){

    $scope.setupStudentIndex = function(){
      $http.get('/api/v1/students.json').then(function(response){
        $scope.students = response.data;
        $scope.activeStudents = [];
        $scope.pendingStudents = [];
        $scope.results = $scope.activeStudents;

        for(var i = 0; i < $scope.students.length; i++){
          var student = $scope.students[i];

          if(student.active){
            $scope.activeStudents.push(student);
          } else  {
            $scope.pendingStudents.push(student);
          }
        }

        // $scope.generateList = function(){
        //   if($scope.selectedList.length === 0){
        //     return $scope.results;
        //   } else {
        //     $scope.results = $scope.selectedList;
        //     return $scope.selectedList;
        //   }
        // };
        $scope.generateList = function(){
          if($scope.selectedList.length === 0){
            return $scope.results;
          } else {
            $scope.results = [];

            for(var i = 0; i < $scope.selectedList.length; i++){
              var tech = $scope.selectedList[i];
              var students = tech.students;

              if(students.length > 0){
                for(var j = 0; j < students.length; j++){
                  var student = students[j];
                  if(student.active){
                    $scope.results.push(student);
                  }
                }
              } 
            }
            return $scope.results;
          }
        };
      });

      $scope.skillOneExists = function(student){
          if(student.skill_1 == ""){
            return false;
          } else {
            return true;
          }
        };

        $scope.skillTwoExists = function(student){
          if(student.skill_2 == ""){
            return false;
          } else {
            return true;
          }
        };

        $scope.skillThreeExists = function(student){
          if(student.skill_3 == ""){
            return false;
          } else {
            return true;
          }
        };

        $scope.skillCheck = function(student){
          if($scope.skillOneExists(student)){
            return true;
          } else if($scope.skillTwoExists(student)){
            return true;
          } else if($scope.skillThreeExists(student)){
            return true;
          } else {
            return false;
          };
        }

      $http.get("/technologies.json").then(function(response){
        $scope.technologies = response.data;
        // $scope.results = $scope.technologies;

        // $scope.generateList = function(){
        //   if($scope.selectedList.length === 0){
        //     return $scope.results;
        //   } else {
        //     $scope.results = $scope.selectedList;
        //     return $scope.selectedList;
        //   }
        // };
      }); 

    };

    window.scope = $scope;
  }]);

}());