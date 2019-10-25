const UserTypes = {
    Master: 'Master',
    Sub: 'Sub'
};
const UserTypesArray = [];

for (let type in UserTypes) {
    UserTypesArray.push(UserTypes[type]);
}

export default UserTypes;

export{
    UserTypesArray
}