// Generated by CoffeeScript 1.4.0
var Curricula,
  __hasProp = {}.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

Curricula = (function(_super) {

  __extends(Curricula, _super);

  function Curricula() {
    return Curricula.__super__.constructor.apply(this, arguments);
  }

  Curricula.prototype.url = "curriculum";

  Curricula.prototype.model = Curriculum;

  return Curricula;

})(Backbone.Collection);
