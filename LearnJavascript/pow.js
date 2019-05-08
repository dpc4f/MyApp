'use strict';

function pow(x, n) {
    return x ** n;
}

let x = prompt('x? ');
let n = prompt('n? ');
if (n < 0)
    alert('Integer ' + n + ' is not supported. Use an integer that greater than zero.');
else
    alert(pow(x, n));