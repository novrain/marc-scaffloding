<template>
    <div id="tags-view-container"
        class="tags-view-container">
        <scroll-pane ref="scrollPane"
            class="tags-view-wrapper">
            <router-link v-for="tag in tags"
                ref="tag"
                :key="tag.key"
                :class="isActive(tag)?'active':''"
                :to="{ path: tag.linkTo, fullPath: tag.fullPath }"
                tag="span"
                class="tags-view-item"
                @click.middle.native="!isAffix(tag)?removeTag(tag):''"
                @contextmenu.prevent.native="openMenu(tag,$event)">
                {{tag.name}}
                <span v-if="!isAffix(tag)"
                    class="el-icon-close"
                    @click.prevent.stop="removeTag(tag)" />
            </router-link>
        </scroll-pane>
        <ul v-show="visible"
            :style="{left:left+'px',top:top+'px'}"
            class="contextmenu">
            <li v-if="!isCurrentRoute(selectedTag)"
                @click="refreshSelectedTag(selectedTag)">刷新</li>
            <li v-if="!isAffix(selectedTag)"
                @click="closeSelectedTag(selectedTag)">关闭</li>
            <li @click="closeOthersTags(selectedTag)">关闭其他</li>
            <li @click="closeAllTags">关闭所有</li>
        </ul>
    </div>
</template>

<script>
import ScrollPane from './ScrollPane'

export default {
    props: ['id', 'containerId'],
    components: { ScrollPane },
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
            visible: false,
            top: 0,
            left: 0,
            selectedTag: ''
        }
    },
    computed: {
        $pathMap() {
            const state = this.$store.state.iota[this.containerId || 'console'][this.id || 'rbac'].menus
            const pathMap = state.pathMap
            return pathMap
        }
    },
    watch: {
        $route() {
            this.handleTag(this.$pathMap[this.$route.path])
            this.moveToCurrentTag()
        },
        $pathMap() {
            this.findAllAffixPath()
        },
        visible(value) {
            if (value) {
                document.body.addEventListener('click', this.closeMenu)
            } else {
                document.body.removeEventListener('click', this.closeMenu)
            }
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
        //关闭当前选中页
        closeSelectedTag(selectedTag) {
            let activeTag = this.activeTag
            this.removeOneCacheView(selectedTag.componentName)
            if (activeTag === selectedTag.linkTo) {
                this.removeTag(selectedTag)
            } else {
                let selectIndex
                this.tags.forEach((tag, i) => {
                    if (tag.id === selectedTag.id) {
                        selectIndex = i
                    }
                })
                this.tags.splice(selectIndex, 1)
            }
        },
        moveToCurrentTag() {
            const tags = this.$refs.tag
            this.$nextTick(() => {
                for (const tag of tags) {
                    if (tag.to.path === this.$route.path) {
                        this.$refs.scrollPane.moveToTarget(tag)
                        break
                    }
                }
            })
        },
        //刷新当前选中页
        refreshSelectedTag(selectedTag) {
            this.removeOneCacheView(selectedTag.componentName)
            this.$nextTick(() => {
                this.$router.replace({ path: selectedTag.linkTo })
            })
        },
        isCurrentRoute(selectedTag) {
            return this.$route.path === selectedTag.linkTo
        },
        //关闭其他标签页
        closeOthersTags(selectedTag) {
            let tags = this.tags
            const cachedViews = this.$store.state.iota[this.containerId || 'console'].cachedViews.map(v => v);
            let otherTags = []
            let selectedCachedViews = []
            tags.forEach((tag) => {
                if (tag.affix || tag === selectedTag) {
                    otherTags.push(tag)
                    if (cachedViews.indexOf(tag.componentName) !== -1) {
                        selectedCachedViews.push(tag.componentName)
                    }
                }
            })
            this.tags = otherTags
            this.activeTag = this.tags[otherTags.length - 1].linkTo
            this.updatePath(this.activeTag)
            this.handleStoreCacheViews(selectedCachedViews)
        },
        //关闭所有已打开的标签页
        closeAllTags() {
            let tags = this.tags
            let affixTags = []
            tags.forEach((tag) => {
                if (tag.affix) affixTags.push(tag)
            })
            this.tags = affixTags
            this.activeTag = affixTags[0].linkTo
            this.updatePath(affixTags[0].linkTo)
            this.clearAllCacheView()
        },
        //判断是否可移除
        isAffix(tag) {
            return tag.affix
        },
        //判断是否激活
        isActive(tag) {
            return tag.linkTo === this.$route.path
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
        },
        openMenu(tag, e) {
            const menuMinWidth = 100
            const offsetLeft = this.$el.getBoundingClientRect().left // container margin left
            const offsetWidth = this.$el.offsetWidth // container width
            const maxLeft = offsetWidth - menuMinWidth // left boundary
            const left = e.clientX - offsetLeft + 220 // TODO margin right  会动态更改
            if (left > maxLeft) {
                this.left = maxLeft
            } else {
                this.left = left
            }
            this.top = e.clientY
            this.visible = true
            this.selectedTag = tag
        },
        closeMenu() {
            this.visible = false
        },
    },
}
</script>

<style lang="stylus" scoped>
.tags-view-container {
    height: 34px;
    width: 100%;
    background: #fff;
    border-bottom: 1px solid #d8dce5;
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.12), 0 0 3px 0 rgba(0, 0, 0, 0.04);

    .tags-view-wrapper {
        .tags-view-item {
            display: inline-block;
            position: relative;
            cursor: pointer;
            height: 26px;
            line-height: 26px;
            border: 1px solid #d8dce5;
            color: #495060;
            background: #fff;
            padding: 0 8px;
            font-size: 12px;
            margin-left: 5px;
            margin-top: 4px;

            &:first-of-type {
                margin-left: 15px;
            }

            &:last-of-type {
                margin-right: 15px;
            }

            &.active {
                background-color: #3860f4;
                color: #fff;
                border-color: #3860f4;

                &::before {
                    content: '';
                    background: #fff;
                    display: inline-block;
                    width: 8px;
                    height: 8px;
                    border-radius: 50%;
                    position: relative;
                    margin-right: 2px;
                }
            }
        }
    }

    .contextmenu {
        margin: 0;
        background: #fff;
        z-index: 3000;
        position: absolute;
        list-style-type: none;
        padding: 5px 0;
        border-radius: 4px;
        font-size: 12px;
        font-weight: 400;
        color: #333;
        box-shadow: 2px 2px 3px 0 rgba(0, 0, 0, 0.3);

        li {
            margin: 0;
            padding: 7px 16px;
            cursor: pointer;

            &:hover {
                background: #eee;
            }
        }
    }
}
</style>

<style lang="stylus" scoped>
// reset element css of el-icon-close
.tags-view-wrapper {
    .tags-view-item {
        .el-icon-close {
            width: 16px;
            height: 16px;
            vertical-align: 2px;
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
                background-color: #5d83ff;
                color: #fff;
            }
        }
    }
}
</style>