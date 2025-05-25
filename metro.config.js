/**
 * Metro configuration
 * https://reactnative.dev/docs/metro
 *
 * @type {import('@react-native/metro-config').MetroConfig}
 */
const {getDefaultConfig, mergeConfig} = require('@react-native/metro-config');

const config = {
resetCache: true // this worked for me
};

module.exports = mergeConfig(getDefaultConfig(__dirname), config);