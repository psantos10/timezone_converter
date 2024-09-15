/**
 * @license MIT
 * topbar 2.0.0, 2023-02-04
 * https://buunguyen.github.io/topbar
 * Copyright (c) 2021 Buu Nguyen
 */
(function (window, document) {
  "use strict";

  // https://gist.github.com/paulirish/1579671
  (function () {
    var lastTime = 0;
    var vendors = ["ms", "moz", "webkit", "o"];
    for (var x = 0; x < vendors.length && !window.requestAnimationFrame; ++x) {
      window.requestAnimationFrame =
        window[vendors[x] + "RequestAnimationFrame"];
      window.cancelAnimationFrame =
        window[vendors[x] + "CancelAnimationFrame"] ||
        window[vendors[x] + "CancelRequestAnimationFrame"];
    }
    if (!window.requestAnimationFrame)
      window.requestAnimationFrame = function (callback, element) {
        var currTime = new Date().getTime(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        var timeToCall = Math.max(0, 16 - (currTime - lastTime), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        var id = window.setTimeout(function () {
          callback(currTime + timeToCall, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        }, timeToCall, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        lastTime = currTime + timeToCall;
        return id;
      };
    if (!window.cancelAnimationFrame)
      window.cancelAnimationFrame = function (id) {
        clearTimeout(id, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      };
  })(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

  var canvas,
    currentProgress,
    showing,
    progressTimerId = null,
    fadeTimerId = null,
    delayTimerId = null,
    addEvent = function (elem, type, handler) {
      if (elem.addEventListener) elem.addEventListener(type, handler, false, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      else if (elem.attachEvent) elem.attachEvent("on" + type, handler, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      else elem["on" + type] = handler;
    },
    options = {
      autoRun: true,
      barThickness: 3,
      barColors: {
        0: "rgba(26,  188, 156, .9)",
        ".25": "rgba(52,  152, 219, .9)",
        ".50": "rgba(241, 196, 15,  .9)",
        ".75": "rgba(230, 126, 34,  .9)",
        "1.0": "rgba(211, 84,  0,   .9)",
      },
      shadowBlur: 10,
      shadowColor: "rgba(0,   0,   0,   .6)",
      className: null,
    },
    repaint = function () {
      canvas.width = window.innerWidth;
      canvas.height = options.barThickness * 5; // need space for shadow

      var ctx = canvas.getContext("2d", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      ctx.shadowBlur = options.shadowBlur;
      ctx.shadowColor = options.shadowColor;

      var lineGradient = ctx.createLinearGradient(0, 0, canvas.width, 0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      for (var stop in options.barColors)
        lineGradient.addColorStop(stop, options.barColors[stop], CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      ctx.lineWidth = options.barThickness;
      ctx.beginPath(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      ctx.moveTo(0, options.barThickness / 2, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      ctx.lineTo(
        Math.ceil(currentProgress * canvas.width),
        options.barThickness / 2
        , CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      ctx.strokeStyle = lineGradient;
      ctx.stroke(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    },
    createCanvas = function () {
      canvas = document.createElement("canvas", CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      var style = canvas.style;
      style.position = "fixed";
      style.top = style.left = style.right = style.margin = style.padding = 0;
      style.zIndex = 100001;
      style.display = "none";
      if (options.className) canvas.classList.add(options.className, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      document.body.appendChild(canvas, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      addEvent(window, "resize", repaint, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
    },
    topbar = {
      config: function (opts) {
        for (var key in opts)
          if (options.hasOwnProperty(key)) options[key] = opts[key];
      },
      show: function (delay) {
        if (showing) return;
        if (delay) {
          if (delayTimerId) return;
          delayTimerId = setTimeout(() => topbar.show(), delay, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        } else {
          showing = true;
          if (fadeTimerId !== null) window.cancelAnimationFrame(fadeTimerId, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
          if (!canvas) createCanvas(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
          canvas.style.opacity = 1;
          canvas.style.display = "block";
          topbar.progress(0, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
          if (options.autoRun) {
            (function loop() {
              progressTimerId = window.requestAnimationFrame(loop, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
              topbar.progress(
                "+" + 0.05 * Math.pow(1 - Math.sqrt(currentProgress), 2)
                , CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
            })(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
          }
        }
      },
      progress: function (to) {
        if (typeof to === "undefined") return currentProgress;
        if (typeof to === "string") {
          to =
            (to.indexOf("+") >= 0 || to.indexOf("-") >= 0
              ? currentProgress
              : 0) + parseFloat(to, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        }
        currentProgress = to > 1 ? 1 : to;
        repaint(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        return currentProgress;
      },
      hide: function () {
        clearTimeout(delayTimerId, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        delayTimerId = null;
        if (!showing) return;
        showing = false;
        if (progressTimerId != null) {
          window.cancelAnimationFrame(progressTimerId, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
          progressTimerId = null;
        }
        (function loop() {
          if (topbar.progress("+.1") >= 1) {
            canvas.style.opacity -= 0.05;
            if (canvas.style.opacity <= 0.05) {
              canvas.style.display = "none";
              fadeTimerId = null;
              return;
            }
          }
          fadeTimerId = window.requestAnimationFrame(loop, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
        })(, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
      },
    };

  if (typeof module === "object" && typeof module.exports === "object") {
    module.exports = topbar;
  } else if (typeof define === "function" && define.amd) {
    define(function () {
      return topbar;
    }, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
  } else {
    this.topbar = topbar;
  }
}.call(this, window, document), CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);
