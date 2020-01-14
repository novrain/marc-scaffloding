<template>
    <div id="tags-view-container"
        class="tags-view-container">
        <a-radio-group size="small"
            buttonStyle="solid"
            v-model="activeTag"
            @change="onChange"
            class="tags-view-wrapper">
            <template>
                <a-radio-button v-for="tag in tags"
                    :key="tag.key"
                    :value="tag.linkTo"
                    class="tags-view-item">{{tag.name}}
                    <span v-if="!isAffix(tag)"
                        class="el-icon-close"
                        @click.prevent.stop="removeTag(tag)" /></a-radio-button>
            </template>
        </a-radio-group>
    </div>
</template>

<script>

export default {
    props: ['id', 'containerId'],
    data() {
        const tags = [{
            id: "",
            name: "",
            key: "",
            linkTo: "",
            icon: "",
            desc: "",
            parentId: "",
            affix: false,
            componentName: ''
        }]

        return {
            activeTag: tags[0].linkTo,
            tags,
        }
    },
    methods: {
        //添加Tag
        handleTag(tagPath) {
            if (!tagPath) {
                return
            }
            let path = tagPath
            let tags = this.tags
            const defaultComponent = this.$route.matched[2].components.default;
            path.componentName = defaultComponent.name
            if (tags.indexOf(path) === -1) {
                tags = [...tags, path]
            }
            tags.forEach(tag => {
                if (tag.id === path.id) {
                    this.activeTag = path.linkTo
                    return
                }
            })
            Object.assign(this, {
                tags
            })
            this.handleCacheView(defaultComponent)
        },
        //移除Tag
        removeTag(targetTag) {
            let activeTag = this.activeTag
            let lastIndex
            this.tags.forEach((tag, i) => {
                if (tag.id === targetTag.id) {
                    lastIndex = i - 1
                }
            })
            const tags = this.tags.filter(tag => tag.id !== targetTag.id)
            if (lastIndex >= 0 && activeTag === targetTag.linkTo) {
                activeTag = tags[lastIndex].linkTo
            }
            this.tags = tags
            this.activeTag = activeTag

            this.updatePath(activeTag)

            this.removeOneCacheView(targetTag.componentName)
        },
        //判断是否可移除
        isAffix(tag) {
            return tag.affix
        },
        //事件监听
        onChange(e) {
            const targetPath = e.target.value
            this.updatePath(targetPath)
        },
        //点击切换地址
        updatePath(targetPath) {
            if (targetPath !== this.$route.path) {
                this.$router.push({ path: targetPath })
            }
        },
        findAllAffixPath() {
            //找出所有的在pathMap中affix为true的路由
            const pathMap = this.$pathMap
            const tags = []
            for (var path in pathMap) {
                if (pathMap[path].affix === true) {
                    tags.push(pathMap[path])
                }
            }
            this.tags = tags
            this.handleTag(this.$pathMap[this.$route.path])
        },
        //添加cachedViews
        handleCacheView(defaultComponent) {
            const cachedViews = this.$store.state.iota[this.containerId || 'console'].cachedViews.map(v => v);
            if (defaultComponent.name &&
                defaultComponent.name != null &&
                cachedViews.indexOf(defaultComponent.name) === -1) {
                cachedViews.push(defaultComponent.name)
            }
            this.handleStoreCacheViews(cachedViews)
        },
        removeOneCacheView(name) {
            const cachedViews = this.$store.state.iota[this.containerId || 'console'].cachedViews.map(v => v);
            var i = cachedViews.indexOf(name)
            if (i !== -1) {
                cachedViews.splice(i, 1)
            }
            this.handleStoreCacheViews(cachedViews)
        },
        clearAllCacheView() {
            let cachedViews = []
            this.handleStoreCacheViews(cachedViews)
        },
        handleStoreCacheViews(cacheViews) {
            this.$store.commit(`iota/${this.containerId}/iota.container.console.cachedViews`, cacheViews)
        }
    },
    watch: {
        $route() {
            this.handleTag(this.$pathMap[this.$route.path])
        },
        $pathMap() {
            this.findAllAffixPath()
        }
    },
    computed: {
        $pathMap() {
            const state = this.$store.state.iota[this.containerId || 'console'][this.id || 'rbac'].menus
            const pathMap = state.pathMap
            return pathMap
        }
    },
}
</script>

<style lang="stylus" scoped>
.tags-view-container {
    overflow: auto;
    overflow-y: hidden;

    .tags-view-wrapper {
        white-space: nowrap;

        .tags-view-item {
            display: inline-block;
            position: relative;
            cursor: pointer;
            height: 28px;
            line-height: 28px;
            padding: 0 8px;
            margin-right: 5px;

            .el-icon-close {
                width: 20px;
                height: 20px;
                vertical-align: 3px;
                border-radius: 50%;
                text-align: center;
                transition: all 0.3s cubic-bezier(0.645, 0.045, 0.355, 1);
                transform-origin: 100% 50%;

                &:before {
                    transform: scale(0.6);
                    display: inline-block;
                    vertical-align: -3px;
                }

                &:hover {
                    background-color: #2d59ea;
                    color: #fff;
                }
            }
        }
    }
}
</style>