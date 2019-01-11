'use strict';

let age;
age = prompt('Input age of a person: ');
alert (!(age >= 14 && age <= 90));

alert(age < 14 || age > 90);

if (-1 || 0) alert( 'first' );
if (-1 && 0) alert( 'second' );
if (null || -1 && 1) alert( 'third' );



