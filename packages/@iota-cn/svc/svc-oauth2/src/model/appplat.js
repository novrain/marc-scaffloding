/**
 * Created by rain on 2016/7/28.
 */

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

export{
    AppPlatArray
}
