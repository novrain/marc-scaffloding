/**
 * Created by rain on 2017/2/17.
 */

//key 必须与模型名称一致
const RSKeys = {
    Interface: 'Interface',
    Protocol: 'Protocol',
    Device: 'Device',
    Thing: 'Thing',
    Deploy: 'Deploy',
    Rule: 'Rule'
};

const RSKeyArray = [];

for (let type in RSKeys) {
    RSKeyArray.push(RSKeys[type]);
}

export default RSKeys;
export {
    RSKeyArray
}
