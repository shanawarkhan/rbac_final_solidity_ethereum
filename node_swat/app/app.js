'use strict';

let express = require('express');
let session = require('express-session');
let eSession = require('easy-session');
let cookieParser = require('cookie-parser');

let app = express();

app.use(cookieParser());
app.use(session({
    secret: 'keyboard cat',
    resave: false,
    saveUninitialized: true
}));
app.use(eSession.main(session));

// Add a path to allow easy login to any role
app.get('/login/:role', function (req, res, next) {
    req.session.login(req.params.role, function () {
        res.redirect('/');
    });
});

// A path to destroy our session
app.get('/logout', function (req, res, next) {
    req.session.logout(function () {
        res.redirect('/');
    });
});

app.get('/', function (req, res, next){
    res.send('Current role is ' + req.session.getRole());
});

// We need no authentication here
app.get('/blog', function (req, res, next) {
    res.send('Cool blog post');
});

app.use(eSession.main(session, {
    rbac: {
        guest: {
            can: ['blog:read']
        },
        writer: {
            can: ['blog:create'],
            inherits: ['guest']
        }
    }
}));

// app.get('/blog/create', function (req, res, next) {
//     // Check if user has access
//     req.session.can('blog:create')
//         .then(function () {
//             res.send('Blog edit');
//         })
//         .catch(function () {
//             res.sendStatus(403);
//         });
// });

app.get('/blog/create', eSession.can('blog:create'), function (req, res, next) {
    res.send('Blog edit');
});

app.listen(3000);