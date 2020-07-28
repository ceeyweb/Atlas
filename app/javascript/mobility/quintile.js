import "bootstrap/js/dist/tooltip";

export default class MobilityQuintile {
  constructor() {
    // constants
    this.regions = {
      "norte": ["baja california", "sonora", "chihuahua", "coahuila", "nuevo leon", "tamaulipas"],
      "norte-occidente": ["baja california sur", "sinaloa", "durango", "zacatecas", "nayarit"],
      "centro-norte": ["san luis potosi", "aguascalientes", "jalisco", "colima", "michoacan", "tlaxcala"],
      "centro": ["guanajuato", "queretaro", "hidalgo", "estado de mexico", "ciudad de mexico", "morelia", "tlaxcala", "puebla"],
      "sur": ["veracruz", "guerrero", "oaxaca", "tabasco", "chiapas", "campeche", "yucatan", "quintana roo"]
    }

    this.colorLegends = [
      "Menor que la media nacional.",
      "Alrededor de la media nacional.",
      "Mayor que la media nacional.",
    ]

    // static attributes
    this.categoryDescription = $("[data-behavior='mobility-category-description']");
    this.quintileTitle       = $("[data-behavior='mobility-quintile-title']");
    this.quintileDescription = $("[data-behavior='mobility-quintile-description']");
    this.kpisRegion          = $("[data-behavior='mobility-kpis-region']");
    this.kpisGender          = $("[data-behavior='mobility-kpis-gender']");
    this.kpisColorScale      = $("[data-behavior='mobility-kpis-color-scale']");

    // dynamic attributes (references only)
    this.quintileSelectors   = "[data-behavior='mobility-quintile-selector']";
    this.categoryButtons     = "[data-behavior='mobility-category-button']";

    // handlers
    this.initEventHandlers();
  }

  initEventHandlers() {
    $(document).on("ajax:success", this.quintileSelectors, function(event) {
      const [data, status, xhr] = event.detail;

      this.updateHeader(data.category.long_title, data.category.description);
      this.updateQuintile(data.title, data.description, data.tooltip);
      this.updateRegionKpis(data.regions);
      this.updateGenderKpis(data.genders);
      this.updateKpisColorScale(data.color_scale);
    }.bind(this));

    $(this.quintileSelectors).click(function (event) {
      this.cleanUpActiveButtons();
      $(event.target).parents('.mobility-dropdown').children('button')
        .addClass('mobility-dropwdown__button--active');
    }.bind(this));
  }

  cleanUpActiveButtons() {
    let activeButtons = $(this.categoryButtons);

    if (activeButtons !== 'undefined'){
      activeButtons.removeClass('mobility-dropwdown__button--active');
    }
  }

  updateHeader(title, description){
    this.categoryDescription.html(`<span>${title}: </span> ${description}`);
  }

  updateQuintile(title, description, tooltip) {
    this.quintileTitle.html(title);
    this.quintileDescription.html(description);

    if(tooltip) {
      this.quintileTitle.append(this.tooltip(tooltip));
      $("[data-toggle='tooltip']").tooltip();
    }
  }

  updateRegionKpis(kpis) {

    $.each(kpis, function(i, kpi) {
      this.kpisRegion
        .find("circle[data-id='" + kpi["region"] + "']")
        .attr("fill", kpi["color"]);

      this.kpisRegion
        .find("[data-id='" + kpi["region"] + "'] > tspan")
        .html(kpi["value"]);

    }.bind(this));
  };

  updateGenderKpis(kpis) {
    let html = "";

    $.each(kpis, function(i, kpi) {
      html += "<li>";
      html += "<span class='mobility-quintile__kpi-group'>";
      html += kpi.gender;

      // Temporarily commented out the logic to show links for gender
      // if(kpi["url"]) {
      //   html += "<a href='" + kpi["url"] + "' data-remote='true'";
      //   html += " data-behavior='mobility-quintile-selector'>";
      //   html += kpi["gender"];
      //   html += "</a>";
      // } else {
      //   html += kpi["gender"];
      // }

      html += "</span>";
      html += "<span class='mobility-quintile__kpi-value' style='color: " + kpi.color + ";'>";
      html += kpi.value;
      html += "</span>";
      html += "</li>";
    }.bind(this));

    this.kpisGender.html(html);
  };

  updateKpisColorScale(colorScale) {
    let html = "";
    let categories = colorScale.categories

    $.each(categories, function printCategories(i, category) {
      html += "<div style='background-color: " + category.color + "; width: "+ category.width +"%'";
      html += " data-toggle='tooltip' title='" + this.colorLegends[i] + "'>";

      if (i == 0) {
        html += "<span>" + colorScale.minimum + "</span>";
        html += "<span>" + (colorScale.average_limits.low - 1) + "</span>";
      } else if (categories.length == (i + 1)){
        html += "<span>" + (colorScale.average_limits.high + 1) + "</span>";
        html += "<span>" + colorScale.maximum + "</span>";
      }

      html += "</div>"
    }.bind(this));

    this.kpisColorScale.css("display", "flex");
    this.kpisColorScale.html(html);
    $("[data-toggle='tooltip']").tooltip();
  }

  tooltip(text) {
    return $("<span></span>", {
      "class": "upward-mobility__i float-right",
      "data-toggle": "tooltip",
      "data-placement": "auto",
      "data-html": "true",
      "title": text,
    }).text("i");
  }
}
