let UserSchema = {
	name: 'LivingSensor',
	properties: {
		temperature: 'int',
		humidity: 'int',
		noize: 'int',
		gas: 'int'
	}
};
var UserRealm = new Realm({
	path: 'user.realm',
	schema: [UserSchema]
});