exports.config =
  files:
    javascripts:
      joinTo:
        'scripts/app.js': /^app/
        'scripts/vendor.js': /^(vendor|bower_components)/

    stylesheets:
      defaultExtension: 'scss'
      joinTo: 'styles/app.css'
