'use strict';


let input;

do  {
    input = prompt('Input a number that greater than 100: ');
    if (input == "" || input == null) break;
} while (input <= 100);