export default class UpwardMobilityIndicator {
  constructor() {
    this.chartContainer             = $("[data-behavior='upward_mobility_chart_container']");
    this.mobilityIndicatorsSelector = "[data-behavior='upward-mobility-indicator-selector']";
    this.chart                      = null;

    this.initEventHandlers();
  }

  initEventHandlers() {
    $(document).ready(function () {
      this.renderChart();
    }.bind(this));

    $(document).on("ajax:success", this.mobilityIndicatorsSelector, function (event) {
      const [data, status, xhr] = event.detail;
      this.updateChart(data);
    }.bind(this));

    $(this.mobilityIndicatorsSelector).click(function setActiveSelector(event){
      this.cleanUpPreviousActiveSelector();
      event.target.classList.add("active");
    }.bind(this));
  };

  updateChart(data) {
    if (this.chart != undefined && this.chart.data != undefined) {
      this.chart.data.datasets = data;
      this.chart.update();
    }
  };

  cleanUpPreviousActiveSelector() {
    document.querySelectorAll(this.mobilityIndicatorsSelector).forEach((selector) => {
      selector.classList.remove("active");
    });
  }

  renderChart() {
    if (this.chartContainer.length) {
      this.chart = new Chart(this.chartContainer, {
        type: 'scatter',
        data: {
          datasets: [{
            data: [{ x: 1, y: 1 }]
          }]
        },
        options: {
          scales: {
            xAxes: [{
              gridLines: {
                drawOnChartArea: false
              },
            }],
            yAxes: [{
              gridLines: {
                drawOnChartArea: false
              }
            }],
          },
          legend: {
            display: false
          },
          tooltips: {
            callbacks: {
              label: function (tooltipItem, data) {
                let info = data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index];
                let x = info.x;
                let y = info.y;
                let state = info.state || '';

                return ` (${y}, ${x}) ${state}`;
              }
            }
          }
        }
      });
    }
  }
}
