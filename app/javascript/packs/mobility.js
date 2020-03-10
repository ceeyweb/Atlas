class MobilityQuintile {
  constructor() {
    // static attributes
    this.quintileTitle       = $("[data-behavior='mobility-quintile-title']");
    this.quintileDescription = $("[data-behavior='mobility-quintile-description']");
    this.kpisRegion          = $("[data-behavior='mobility-kpis-region']");
    this.kpisGender          = $("[data-behavior='mobility-kpis-gender']");
    this.kpisColorScale      = $("[data-behavior='mobility-kpis-color-scale']");

    // dynamic attributes (references only)
    this.quintileSelectors   = "[data-behavior='mobility-quintile-selector']";

    // hanlders
    this.initEventHandlers();
  }

  initEventHandlers() {
    $(document).on("ajax:success", this.quintileSelectors, function(event) {
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

  updateRegionKpis(kpis) {
    let html = "";

    $.each(kpis, function(i, kpi) {
      html += "<div>";
      html += kpi["region"] + ": " + kpi["value"];
      html += "</div>";
    }.bind(this));

    this.kpisRegion.html(html);
  };

  updateGenderKpis(kpis) {
    let html = "";

    $.each(kpis, function(i, kpi) {
      html += "<li>";
      html += "<span class='mobility-quintile__kpi-group'>";

      if(kpi["url"]) {
        html += "<a href='" + kpi["url"] + "' data-remote='true'";
        html += "data-behavior='mobility-quintile-selector'>";
        html += kpi["gender"];
        html += "</a>";
      } else {
        html += kpi["gender"];
      }

      html += "</span>";
      html += "<span class='mobility-quintile__kpi-value";
      html += " mobility-quintile__kpi-value--q" + kpi["color_index"] + "'>";
      html += kpi["value"] + "</span>";
      html += "</li>";
    }.bind(this));

    this.kpisGender.html(html);
  };

  updateKpisColorScale(colorScale) {
    const klass = "mobility-quintile__color-scale--gradient-" + colorScale["direction"];
    let html = "";

    html += "<span> <" + colorScale["minimum"] + "</span>";
    html += "<span> >" + colorScale["maximum"] + "</span>";

    this.kpisColorScale.removeClass();
    this.kpisColorScale.addClass("mobility-quintile__color-scale " + klass);
    this.kpisColorScale.html(html);
  }
}

$(document).on("turbolinks:load", function() {
  new MobilityQuintile();
});
