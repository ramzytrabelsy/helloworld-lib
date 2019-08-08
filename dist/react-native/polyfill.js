"use strict";

/* eslint-disable global-require */

/**
 * Intl
 */
if (!global.Intl) {
  require('intl');

  require('intl/locale-data/jsonp/en');

  require('intl/locale-data/jsonp/fr');
}
//# sourceMappingURL=polyfill.js.map