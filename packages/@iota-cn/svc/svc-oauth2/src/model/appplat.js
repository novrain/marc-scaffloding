const AppPlat = {
    iOS: 'iOS',
    Android: 'Android',
    Web: 'Web',
    Application: 'Application'
};
const AppPlatArray = [];

for (let plat in AppPlat) {
    AppPlatArray.push(AppPlat[plat]);
}

export default AppPlat;

export {
    AppPlatArray
}
