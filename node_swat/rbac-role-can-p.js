return Q.any($role.inherits.map(child => this.can(child, operation, params)))
    .then(resolve, reject);