const flatten = arr => arr.reduce((acc, val) => acc.concat(val), []);

module.exports = flatten;
