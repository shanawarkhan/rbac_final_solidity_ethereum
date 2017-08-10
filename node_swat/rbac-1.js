let roles = {
    manager: {
        can: ['read', 'write', 'publish']
    },
    writer: {
        can: ['read', 'write']
    },
    guest: {
        can: ['read']
    }
}


function can(role, operation) {
    return roles[role] && roles[role].can.indexOf(operation) !== -1;
}