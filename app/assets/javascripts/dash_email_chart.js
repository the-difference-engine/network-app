$(function () { 
    $.get("/api/v1/students.json",  function(response) {
      var activeStudents = [];
      var chartEmailData = [];
      var students = response

      for(var i = 0; i < students.length; i++){
        var student = students[i];

        if(student.active){
          activeStudents.push(student);
        }
      }

      for(var i = 0; i < activeStudents.length; i++){
        chartEmailData.push(
          {
            name: activeStudents[i].full_name,
            data: [ activeStudents[i].employer_emails.length ]
          }
        );
      }

      $('#email-stat-chart').highcharts({
        chart: {
            type: 'bar'
        },
        title: {
            text: 'Employer Emails Received By Students'
        },
        xAxis: {
            categories: ['Students']
        },
        yAxis: {
            title: {
                text: 'Emails Received'
            }
        },
        series: chartEmailData       
      });
    });
  });