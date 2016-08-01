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

          // $scope.chunkedStudentData = chunk($scope.activeStudents, 3);
        }

        // function chunk(arr, size) {
        //     var newArray = [];
        //     for (var i=0; i<arr.length; i+=size) {
        //       newArray.push(arr.slice(i, i+size));
        //     }
        //     return newArray;
        //   }

        $scope.skillExists = function(student){
          if(student.skill_1 == ""){
            return false;
          } else {
            return true;
          }
        };
      });



      // $http.get("/technologies.json").then(function(response){
      //   $scope.technologies = response.data;
      //   $scope.results = $scope.technologies;

      //   $scope.generateList = function(){
      //     if($scope.selectedList.length === 0){
      //       return $scope.results;
      //     } else {
      //       $scope.results = $scope.selectedList;
      //       return $scope.selectedList;
      //     }
      //   };
      // }); 
    };

    window.scope = $scope;
  }]);

}());