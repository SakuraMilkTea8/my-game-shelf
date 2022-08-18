import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

import "controllers"
import "bootstrap"

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
});
