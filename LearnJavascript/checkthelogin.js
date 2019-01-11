'use strict';

let user = prompt('Enter username: ');
if (user == null || user == "") {
    alert('Canceled.');
} else if (user == 'Admin') {
    let pass = prompt('Enter password: ');
    if (pass == null || pass == "") {
        alert('Canceled.');
    } else if (pass == 'TheMaster') {
        alert('Welcome!');
    } else {
        alert('Wrong password.');
    }
} else {
    alert('I don\'t know you.');
}

let message;
message = (login == 'Employee') ? 'Hello' :
            (login == 'Director') ? 'Greetings' :
            (login == '') ? 'No login' : '';