Technology.create!([
  {name: "Ruby"},
  {name: "Ruby on Rails"},
  {name: "AngularJS"},
  {name: "SQL"},
  {name: "Sinatra"},
  {name: "PostgreSQL"},
  {name: "RSpec"},
  {name: "Capybara"},
  {name: "Jasmine"},
  {name: "Python"},
  {name: "MongoDB"},
  {name: "Node.js"},
  {name: "Express"},
  {name: "Backbone.js"},
  {name: "Foundation"},
  {name: "Java"},
  {name: "React"},
  {name: "PHP"},
  {name: "Firebase"},
  {name: "C++"},
  {name: "Sass"},
  {name: "D3.js"},
  {name: "Handlebars"},
  {name: "Meteor"},
  {name: "Photoshop"},
  {name: "Ionic"},
  {name: "Django"},
  {name: "Swift"},
  {name: "C"},
  {name: "Selenium"},
  {name: "Ember.js"},
  {name: "C#"},
  {name: ".Net"},
  {name: "R"},
  {name: "Mongoose"},
  {name: "MATLAB"},
  {name: "Drupal"},
  {name: "PhoneGap"},
  {name: "Cordova"},
  {name: "Flask"},
  {name: "Cucumber"},
  {name: "Pearl"},
  {name: "ASP.net"},
  {name: "iOS"},
  {name: "Android"},
  {name: "Go"},
  {name: "Elixir"},
  {name: "Erlang"},
  {name: "Rust"},
  {name: "Scala"},
  {name: "Clojure"},
  {name: "CouchDB"},
  {name: "Hadoop"},
  {name: "Hive"},
  {name: "Spark"},
  {name: "Language Agnostic"},
  {name: "Objecive-C"},
  {name: "CoffeeScript"},
  {name: "JavaScript"},
  {name: "HTML"},
  {name: "CSS"}
])

Position.create!([
  {name: "Back-End Developer"},
  {name: "Front-End Developer"},
  {name: "UX/UI"},
  {name: "Full-Stack Developer"},
  {name: "Support/Test/QA"},
  {name: "Data Scientist"},
  {name: "Data Engineer"},
  {name: "Data Analyst"},
  {name: "Other"}
])

PositionType.create!([
  {name: "Full Time"},
  {name: "Part-Time"},
  {name: "Remote"},
  {name: "Contract/Freelance"},
  {name: "Contract-To-Hire"},
  {name: "Apprenticeship"},
  {name: "Internship"}
])

Industry.create!([
  {name: "Finance"},
  {name: "Education"},
  {name: "Startup"},
  {name: "Marketing"},
  {name: "Other"},
  {name: "Media & Advertising"},
  {name: "Consumer Products"},
  {name: "Consulting"},
  {name: "Government"},
  {name: "Non-Profit"},
  {name: "Data & Logistics"},
  {name: "Security"},
  {name: "Travel & Entertainment"},
  {name: "Healthcare & Science"},
  {name: "Construction"},
  {name: "Agriculture"},
  {name: "Transportation"},
  {name: "Corporate Services"}
])

SalaryRange.create!([
  {salary_range: "Less than $35,000"},
  {salary_range: "$35,000 - $55,000"},
  {salary_range: "$55,000 - $75,000"},
  {salary_range: "$75,000 - $95,000"},
  {salary_range: "$95,000 - $115,000"},
  {salary_range: "$115,000 - $130,000"},
  {salary_range: "$130,000 +"}
])
