let Q = require('q');
can(role, operation, params, cb) {
    let callback = cb || () => {};
    return Q.Promise((resolvePromise, rejectPromise) => {

        // Collect resolve handling
        function resolve(value) {
            resolvePromise(result);
            callback(undefined, result);
        }

        // Collect error handling
        function reject(err) {
            rejectPromise(err);
            callback(err);
        }

        // our function
        // ... //

    });
}