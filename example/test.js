const Distance = require('../lib/geo-distance');

console.log('Convert KMs to Miles -> ' + Distance('50 km').human_readable('customary'));

const Oslo = {
  lat: 59.914,
  lon: 10.752
};

const Berlin = {
  lat: 52.523,
  lon: 13.412
};
const OsloToBerlin = Distance.between(Oslo, Berlin);

console.log('' + OsloToBerlin.human_readable());
if (OsloToBerlin > Distance('800 km')) {
  console.log('Nice journey!');
}