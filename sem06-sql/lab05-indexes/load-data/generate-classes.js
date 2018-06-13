const flatten = require('./flatten');

const alphabet = Array.from('ABCDEFGHIJKLMNOPQRSTUVWXYZ');

const addLetter = n => alphabet.map(l => `${n}${l}`);

const recurseLetters = i => items =>
  i === 0 ? items : flatten(recurseLetters(i - 1)(items).map(addLetter));

module.exports = recurseLetters;
