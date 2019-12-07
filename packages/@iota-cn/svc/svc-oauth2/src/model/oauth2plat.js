const OAuth2Plat = {
    WeChat: 'WeChat',
    GitHub: 'GitHub'
};
const OAuth2PlatArray = [];

for (let plat in OAuth2Plat) {
    OAuth2PlatArray.push(OAuth2Plat[plat]);
}

export default OAuth2Plat;

export {
    OAuth2PlatArray
}
