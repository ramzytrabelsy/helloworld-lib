// @IMPORTANT prefer Babel transform when possible

/**
 * process.nextTick
 */

if (!process.nextTick) {
  process.nextTick = setImmediate;
}

/**
 * Promise.prototype.finally
 * this is necessary for React Native to fix incorrect implementation
 */

// eslint-disable-next-line no-extend-native
Object.defineProperty(Promise.prototype, 'finally', {
  configurable: true,
  writable: true,
  value: require('promise.prototype.finally/implementation'),
});

/**
 * Intl
 */

if (!global.Intl) {
  require('intl');
  require('intl/locale-data/jsonp/en.js');
  require('intl/locale-data/jsonp/fr.js');
}
