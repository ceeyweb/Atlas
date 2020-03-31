import MobilityQuintile from "../mobility/quintile";
import { mapael } from "jquery-mapael";
import "../mobility/mexico.min";

$(document).on("turbolinks:load", function() {
  new MobilityQuintile();

  $(".mobility-map").mapael({
    map: {
      name: "mexico",
      cssClass: "mobility-map__map",
      defaultArea: {
        attrs: {
          stroke: "#ffffff",
          "stroke-width": 1,
        },
      },
      defaultPlot: {
        type: "circle",
        size: 30,
        attrs : {
          stroke: "#ffffff",
          "stroke-width": 1,
          opacity : 0.9,
        },
        attrsHover: {
          "stroke-width": 4,
          opacity : 1,
        },
        text: {
          attrs: {
            "font-size": 40,
            fill: "#ffffff",
          },
          attrsHover: { fill: "#ffffff" },
        },
      },
    },
    plots: {
      "norte": {
        x: 740,
        y: 360,
        text: { content: "-" },
      },
      "norte-occidente": {
        x: 850,
        y: 650,
        text: { content: "-" },
      },
      "centro-norte": {
        x: 950,
        y: 900,
        text: {
          content: "-",
          position: "bottom",
          margin: 25,
        },
      },
      "centro": {
        x: 1240,
        y: 920,
        text: {
          content: "-",
          position: "bottom",
          margin: 25,
        },
      },
      "sur": {
        x: 1350,
        y: 1120,
        text: { content: "-" },
      },
    },
    legend: {
      area: {
        cssClass: "mobility-map__legend",
        slices: [
          {
            sliceValue: "norte",
            attrs: { fill: "#145861" },
            attrsHover: { fill: "#145861" },
            label: "Norte",
          },
          {
            sliceValue: "norte-occidente",
            attrs: { fill: "#41939c" },
            attrsHover: { fill: "#41939c" },
            label: "Norte-Occidente",
          },
          {
            sliceValue: "centro-norte",
            attrs: { fill: "#959696" },
            attrsHover: { fill: "#959696" },
            label: "Centro-Norte",
          },
          {
            sliceValue: "centro",
            attrs: { fill: "#cdcbca" },
            attrsHover: { fill: "#cdcbca" },
            label: "Centro",
          },
          {
            sliceValue: "sur",
            attrs: { fill: "#f58531" },
            attrsHover: { fill: "#f58531" },
            label: "Sur",
          },
        ]
      },
    },
    areas: {
      "baja california": { value: "norte" },
      "sonora": { value: "norte" },
      "chihuahua": { value: "norte" },
      "coahuila": { value: "norte" },
      "nuevo leon": { value: "norte" },
      "tamaulipas": { value: "norte" },
      "baja california sur": { value: "norte-occidente" },
      "sinaloa": { value: "norte-occidente" },
      "durango": { value: "norte-occidente" },
      "zacatecas": { value: "norte-occidente" },
      "nayarit": { value: "norte-occidente" },
      "san luis potosi": { value: "centro-norte" },
      "aguascalientes": { value: "centro-norte" },
      "jalisco": { value: "centro-norte" },
      "colima": { value: "centro-norte" },
      "michoacan": { value: "centro-norte" },
      "tlaxcala": { value: "centro-norte" },
      "guanajuato": { value: "centro" },
      "queretaro": { value: "centro" },
      "hidalgo": { value: "centro" },
      "estado de mexico": { value: "centro" },
      "ciudad de mexico": { value: "centro" },
      "morelia": { value: "centro" },
      "tlaxcala": { value: "centro" },
      "puebla": { value: "centro" },
      "veracruz": { value: "sur" },
      "guerrero": { value: "sur" },
      "oaxaca": { value: "sur" },
      "tabasco": { value: "sur" },
      "chiapas": { value: "sur" },
      "campeche": { value: "sur" },
      "yucatan": { value: "sur" },
      "quintana roo": { value: "sur" },
    },
  });

  $("path, rect, text").on('mouseover mouseenter mouseleave mouseup mousedown', function() {
    return false
  });
});
