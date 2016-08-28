$(function () { 
  $.get("/api/v1/students.json",  function(response) {
    var activeStudents = [];
    var chartEmployerEmailData = [];
    var students = response;

    for(var i = 0; i < students.length; i++){
      var student = students[i];

      if(student.active){
        activeStudents.push(student);
      }
    }

    for(var i = 0; i < activeStudents.length; i++){
      if(activeStudents[i].employer_emails.length > 0){
        chartEmployerEmailData.push(
          {
            name: activeStudents[i].full_name,
            data: [ activeStudents[i].employer_emails.length ]
          }
        );
      }
    }

    $('#employer-email-stat-chart').highcharts({
      chart: {
        type: 'bar'
      },
      legend: {
          enabled: false
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
      series: chartEmployerEmailData       
    });
  });

  $.get("/api/v1/employers.json",  function(response) {
    var activeEmployers = [];
    var chartStudentEmailData = [];
    var employers = response;

    for(var i = 0; i < employers.length; i++){
      var employer = employers[i];

      if(employer.active){
        activeEmployers.push(employer);
      }
    }

    for(var i = 0; i < activeEmployers.length; i++){
      if(activeEmployers[i].student_emails.length > 0){
        chartStudentEmailData.push(
          {
            name: activeEmployers[i].name,
            data: [ activeEmployers[i].student_emails.length ]
          }
        );
      }
    }

    $('#student-email-stat-chart').highcharts({
      chart: {
        type: 'bar'
      },
      legend: {
          enabled: false
      },
      title: {
        text: 'Student Emails Received By Employers'
      },
      xAxis: {
        categories: ['Employers']
      },
      yAxis: {
        title: {
          text: 'Emails Received'
        }
      },
      series: chartStudentEmailData       
    });
  });
});

