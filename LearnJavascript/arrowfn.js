'use strict';

let yes = () => alert("You agreed.");
let no = () => alert("You canceled the execution.");

let ask = (question, yes, no) => {
    if (confirm(question)) yes()
    else no();
};

ask("Do you agree? ", yes, no);