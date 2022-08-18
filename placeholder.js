
console.log('Hello from application.js')

// require chart.js
var Chart = require('chart.js')


//  add data attributes
var ctx = document.getElementById('myChart');
debugger;
var myChart = new Chart(ctx, {
    type: 'bar',
    data: {
        labels: ['completed', 'Now playing', 'Want to play'],
        datasets: [{
            label: 'Games',
            data: JSON.parse(ctx.dataset.pageViews),
            borderWidth: 1
        }]
    },
    backgroundColor: [
      'rgba(255, 99, 132, 0.2)',
      'rgba(54, 162, 235, 0.2)',
      'rgba(255, 206, 86, 0.2)',
      'rgba(75, 192, 192, 0.2)',
      'rgba(153, 102, 255, 0.2)',
      'rgba(255, 159, 64, 0.2)'
  ],
  borderColor: [
      'rgba(255, 99, 132, 1)',
      'rgba(54, 162, 235, 1)',
      'rgba(255, 206, 86, 1)',
      'rgba(75, 192, 192, 1)',
      'rgba(153, 102, 255, 1)',
      'rgba(255, 159, 64, 1)'
  ],
});
