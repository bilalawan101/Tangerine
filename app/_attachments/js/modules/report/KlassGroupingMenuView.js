var KlassGroupingMenuView,
  __hasProp = Object.prototype.hasOwnProperty,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

KlassGroupingMenuView = (function(_super) {

  __extends(KlassGroupingMenuView, _super);

  function KlassGroupingMenuView() {
    KlassGroupingMenuView.__super__.constructor.apply(this, arguments);
  }

  KlassGroupingMenuView.prototype.events = {
    'change .part_selector': 'gotoKlassGroupingReport'
  };

  KlassGroupingMenuView.prototype.gotoKlassGroupingReport = function(event) {
    return Tangerine.router.navigate(("report/klassGrouping/" + this.klass.id + "/") + this.$el.find(event.target).find(":selected").attr("data-part"), true);
  };

  KlassGroupingMenuView.prototype.initialize = function(options) {
    var _this = this;
    this.parent = options.parent;
    this.klass = this.parent.options.klass;
    this.curricula = this.parent.options.curricula;
    this.currentPart = this.klass.calcCurrentPart();
    this.students = new Students;
    return this.students.fetch({
      klassId: this.klass.id,
      success: function() {
        var allSubtests;
        allSubtests = new Subtests;
        return allSubtests.fetch({
          success: function(collection) {
            var subtest, subtests, _i, _len;
            subtests = collection.where({
              curriculaId: _this.curricula.id
            });
            _this.parts = [];
            for (_i = 0, _len = subtests.length; _i < _len; _i++) {
              subtest = subtests[_i];
              if (!(_this.parts[subtest.get('part')] != null)) {
                _this.parts[subtest.get('part')] = {};
              }
              _this.parts[subtest.get('part')]["id"] = subtest.id;
              if (_this.parts[subtest.get('part')]["name"] != null) {
                _this.parts[subtest.get('part')]["name"] += " " + subtest.get("name");
              } else {
                _this.parts[subtest.get('part')]["name"] = subtest.get("name");
              }
            }
            _this.ready = true;
            return _this.render();
          }
        });
      }
    });
  };

  KlassGroupingMenuView.prototype.render = function() {
    var flagForCurrent, html, part, subtest, _len, _ref;
    if (this.ready) {
      if (!(this.students != null) || this.students.length === 0) {
        this.$el.html("Please add students to this class.");
        return;
      }
      html = "        <select class='part_selector'>          <option disabled='disabled' selected='selected'>Select an assessment</option>          ";
      _ref = this.parts;
      for (part = 0, _len = _ref.length; part < _len; part++) {
        subtest = _ref[part];
        if ((subtest != null ? subtest.id : void 0) != null) {
          flagForCurrent = this.currentPart === part ? "**" : '';
          html += "<option data-part='" + part + "' data-subtestId='" + subtest.id + "'>" + flagForCurrent + " " + part + " " + subtest.name + "</option>";
        }
      }
      html += "</select>";
      return this.$el.html(html);
    } else {
      return this.$el.html("<img src='images/loading.gif' class='loading'>");
    }
  };

  return KlassGroupingMenuView;

})(Backbone.View);
