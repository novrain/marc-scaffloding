/**
 * 转换为属性结构
 * 
 * @param {接口返回的菜单列表} lists 
 */
const convertMenus = (lists) => {
    let [map, roots, nodeMap, pathMap] = [{}, [], {}, {}];

    lists.map((item, i) => {
        let node = item;
        node.children = [];
        map[node.id] = i;
        nodeMap[node.id] = node;
        if (node.linkTo !== undefined) {
            pathMap[node.linkTo] = node
        }
    });

    for (let i = 0; i < lists.length; i += 1) {
        let node = lists[i];
        if (node.parentId !== null) {
            lists[map[node.parentId]].children.push(node);
        } else {
            roots.push(node);
        }
    }

    return {
        roots,
        idMap: nodeMap,
        pathMap,
        lists
    }
}

export {
    convertMenus,
    convertMenus as createTree
}