export default class UpwardMobilityIndicator {
  constructor() {
    this.chartContainer             = $("[data-behavior='upward_mobility_chart_container']");
    this.mobilityIndicatorsSelector = "[data-behavior='upward-mobility-indicator-selector']";
    this.chart                      = new Chart(this.chartContainer, {
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
              return data.datasets[tooltipItem.datasetIndex].data[tooltipItem.index].state || '';
            }
          }
        }
      }
    });

    this.initEventHandlers();
  }

  initEventHandlers() {
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
    this.chart.data.datasets = data;
    this.chart.update();
  };

  cleanUpPreviousActiveSelector() {
    document.querySelectorAll(this.mobilityIndicatorsSelector).forEach((selector) => {
      selector.classList.remove("active");
    });
  }
}
