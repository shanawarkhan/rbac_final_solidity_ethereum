can(role, operation, params) {
    // Check if role exists
    if(!this.roles[role]) {
        return false;
    }
    let $role = this.roles[role];
    // Check if this role has this operation
    if($role.can[operation]) {
        // Not a function so we are good
        if(typeof $role.can[operation] !== 'function') {
            return true;
        }
        // If the function check passes return true
        if($role.can[operation](params)) {
            return true;
        }
    }
  
    // Check if there are any parents
    if(!$role.inherits || $role.inherits.length < 1) {
        return false;
    }
  
    // Check child roles until one returns true or all return false
    return $role.inherits.some(childRole => this.can(childRole, operation, params));
}