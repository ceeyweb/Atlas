class MobilityQuintile {
  constructor() {
    this.quintileSelectors   = $("[data-behavior='mobility-quintile-selector']");
    this.quintileTitle       = $("[data-behavior='mobility-quintile-title']");
    this.quintileDescription = $("[data-behavior='mobility-quintile-description']");
    this.kpisRegion          = $("[data-behavior='mobility-kpis-region']");
    this.kpisGender          = $("[data-behavior='mobility-kpis-gender']");
    this.kpisColorScale      = $("[data-behavior='mobility-kpis-color-scale']");

    this.initEventHandlers();
  }

  initEventHandlers() {
    this.quintileSelectors.on("ajax:success", function(event) {
      const [data, status, xhr] = event.detail;

      this.updateQuintile(data["title"], data["description"]);
      this.updateRegionKpis(data["regions"]);
      this.updateGenderKpis(data["genders"]);
      this.updateKpisColorScale(data["color_scale"]);
    }.bind(this));
  }

  updateQuintile(title, description) {
    this.quintileTitle.html(title);
    this.quintileDescription.html(description);
  }

  updateRegionKpis(regions) {
    let html = "";

    $.each(regions, function(i, region) {
      html += "<div>";
      html += region["description"] + ": " + region["value"];
      html += "</div>";
    }.bind(this));

    this.kpisRegion.html(html);
  };

  updateGenderKpis(genders) {
    let html = "";

    $.each(genders, function(i, gender) {
      html += "<li>";
      html += "<span class='mobility-quintile__kpi-group'>";
      html += gender["description"];
      html += "</span>";
      html += "<span class='mobility-quintile__kpi-value mobility-quintile__kpi-value--q6'>";
      html += gender["value"] + "</span>";
      html += "</li>";
    }.bind(this));

    this.kpisGender.html(html);
  };

  updateKpisColorScale(colorScale) {
    const klass = "mobility-quintile__color-scale--gradient-" + colorScale["direction"];
    let html = "";

    html += "<span> <" + colorScale["min"] + "</span>";
    html += "<span> >" + colorScale["max"] + "</span>";

    this.kpisColorScale.addClass(klass);
    this.kpisColorScale.html(html);
  }
}

$(document).on("turbolinks:load", function() {
  new MobilityQuintile();
});
