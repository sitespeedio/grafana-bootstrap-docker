#!/usr/bin/env node

'use strict';

const fs = require('fs'),
  path = require('path');

const dashboards = fs.readdirSync('dashboards-original');
for (const dashboard of dashboards) {
  var content = fs.readFileSync(path.join('dashboards-original', dashboard), {
    encoding: 'utf8'
  });
  content = "{ \"dashboard\":" + content.replace(/(\$\{DS_GRAPHITE\}|DS_GRAPHITE)/g, "graphite") + " }";
  fs.writeFileSync(path.join('dashboards', dashboard), content, {
    encoding: 'utf8'
  });
}
