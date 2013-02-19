// Generated by CoffeeScript 1.4.0
var ConsentPrintView,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

ConsentPrintView = (function(_super) {

  __extends(ConsentPrintView, _super);

  function ConsentPrintView() {
    return ConsentPrintView.__super__.constructor.apply(this, arguments);
  }

  ConsentPrintView.prototype.className = "ConsentPrintView";

  ConsentPrintView.prototype.initialize = function(options) {
    this.confirmedNonConsent = false;
    this.model = this.options.model;
    return this.parent = this.options.parent;
  };

  ConsentPrintView.prototype.render = function() {
    var markingArea, spanClass;
    if (this.format === "stimuli") {
      return;
    }
    if (this.format === "content" || this.format === "backup") {
      spanClass = "print-question-option";
      markingArea = "☐";
      this.$el.html("        <div class='subtest-title'>" + (this.model.get("name")) + "</div>        <span class='" + spanClass + "'>" + (this.model.get('prompt') || 'Does the child consent?') + " " + markingArea + "</span>      ");
    }
    return this.trigger("rendered");
  };

  return ConsentPrintView;

})(Backbone.View);
