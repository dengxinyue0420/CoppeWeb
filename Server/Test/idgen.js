function idgen (){
    var FlakeIdGen = require('flake-idgen')
	, intformat = require('biguint-format')
	, generator = new FlakeIdGen;
    return intformat( generator.next(),'dec');
}

console.log(idgen());