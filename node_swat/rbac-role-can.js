$role.can[operation](params, function (err, result) { 
    if(err) { 
        return reject(err); 
    } 
    if(!result) { 
        return reject(false); 
    } 
    resolve(true); 
});