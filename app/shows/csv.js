// Generated by CoffeeScript 1.4.0

(function(doc, req) {
  log(req);
  return {
    "headers": {
      "Content-Type": "text/csv",
      "Content-Disposition": "attachment; filename=\"" + req.query.filename + ".csv\"",
      "Pragma": "no-cache",
      "Expires": "0"
    },
    "body": doc.csv
  };
});
