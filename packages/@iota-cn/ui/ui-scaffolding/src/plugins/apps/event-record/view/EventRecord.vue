<script>
import moment from 'moment'
export default {
    data() {
        return {
            limit: 80,
            page: 1,
            total: 1,
            items: [],
            logType: null,
            status: null,

        };
    },
    created() { },
    computed() { },
    mounted() {
        //请求接口获取数据
        this.refetchRecords();
    },
    methods: {
        //统一请求接口
        refetchRecords() {
            var queryStr = `/v1/api/records?limit=${this.limit}&offset=${(this.page - 1) * this.limit}`
            if (this.logType !== null) {
                queryStr += `&logType=${this.logType}`
            } else if (this.status !== null) {
                queryStr += `&status=${this.status}`
            }
            this.$axios
                .silentGet(queryStr, true)
                .then(res => {
                    this.items = res.data.records.map(r => {
                        r.browser = JSON.parse(r.browser || {});
                        r.createdAt = moment(r.createdAt).format('YYYY-MM-DD HH:mm:ss')
                        return r;
                    });
                    this.total = res.data.total;
                })
                .catch(err => {
                    console.log("error", err);
                });
        },
        //刷新
        reloadRecords() {
            this.limit = 80
            this.page = 1
            this.total = 1
            this.logType = null
            this.status = null
            this.refetchRecords()
        },
        //limit改变
        onLimitChange(current, pageSize) {
            this.limit = pageSize
            this.page = 1
            this.refetchRecords()
        },
        //currentPage改变
        onPageChange(page) {
            this.page = page
            this.refetchRecords()
        },
        //status Filters
        onStatusFiltersChange(status) {
            if (status !== this.status) {
                this.status = status
                this.refetchRecords()
            }
        },
        //logType Filters
        onLogTypeFiltersChange(logType) {
            if (logType === null || logType === 'all') {
                this.logType = null
            } else {
                this.logType = logType
            }
            this.refetchRecords()
        },
        //下拉框
        logTypeFilterWidgets() {
            return (
                <a-select defaultValue="all" style="width: 120px" onChange={this.onLogTypeFiltersChange}>
                    <a-select-option value="all">全部记录</a-select-option>
                    <a-select-option value="sys_record">系统记录</a-select-option>
                    <a-select-option value="user_record">用户操作记录</a-select-option>
                </a-select>
            )
        },
        //页面配置
        renderItems() {
            const pageSizeOptions = ['5', '10', '60', '80']
            const columns = [
                {
                    title: "用户昵称",
                    dataIndex: "username",
                    key: "username",
                    width: "10%"
                },
                {
                    title: "用户ip",
                    dataIndex: "request_ip",
                    key: "request_ip",
                    width: "10%",
                    customRender: (text, record) => {
                        return record.request_ip !== "undefined"
                            ? record.request_ip
                            : "未记录";
                    },
                },
                {
                    title: "请求地址",
                    dataIndex: "host",
                    key: "host",
                    width: "10%"
                },
                {
                    title: "请求类型",
                    dataIndex: "method",
                    key: "method",
                    width: "8%"
                },
                {
                    title: "响应值",
                    dataIndex: "status",
                    key: "status",
                    width: "4%"
                },
                {
                    title: "处理耗时(ms)",
                    dataIndex: "time",
                    key: "time",
                    width: "8%"
                },
                {
                    title: "事件描述",
                    dataIndex: "description",
                    key: "description"
                },
                {
                    title: this.logTypeFilterWidgets(),
                    dataIndex: "log_type",
                    key: "log_type",
                    width: "8%",
                    customRender: (text, record) => {
                        return record.log_type === "sys_record"
                            ? "系统记录"
                            : record.log_type === "user_record"
                                ? "用户操作记录"
                                : "未知异常";
                    },
                    render: (text) => {
                        switch (text) {
                            case 'all':
                                return '操作记录';
                            case 'sys_record':
                                return '系统记录';
                            case 'user_record':
                                return '用户操作记录';
                        }
                    }
                },
                {
                    title: "访问时间",
                    dataIndex: "createdAt",
                    key: "createdAt",
                    width: "10%"
                },
                {
                    title: "浏览器",
                    dataIndex: "browser.browser",
                    key: "browser",
                    width: "8%"
                },
                {
                    title: "设备类型",
                    dataIndex: "browser.terminal",
                    key: "terminal",
                    width: "8%"
                }
            ];
            return (
                <a-card
                    title={
                        <div class="ii-card-head">
                            <IiIcon type="list" />
                            <span>记录列表</span>
                        </div>
                    }
                    bordered={false}
                    bodyStyle={{ padding: "2px", flex: 1, height: 0 }}
                    style={{
                        height: "100%",
                        width: "100%",
                        overflow: "hidden",
                        backgroundColor: "white",
                        display: "flex",
                        flexDirection: "column"
                    }}>
                    {this.$p("") ? (
                        <AButton
                            style={{ marginRight: "8px" }}
                            slot="extra"
                            size="small"
                            key="add"
                            onClick={this.reloadRecords}>
                            <AIcon type="reload" />
                            刷新
                        </AButton>
                    ) : null}
                    <IiTableLayout
                        size="small"
                        headheight={68}
                        total={this.total}
                        pageSize={this.limit}
                        currentPage={this.page}
                        showSizeChanger={true}
                        onShowSizeChange={this.onLimitChange}
                        onPaginationChange={this.onPageChange}
                        pageSizeOptions={pageSizeOptions}
                        onRowClick={this.onDictionaryClick}
                        class={"table"}
                        showPagination="both"
                        columns={columns}
                        rows={this.items}
                    ></IiTableLayout>
                </a-card>
            );
        }
    },
    render() {
        return (
            <div class="ii-event-record">
                <splitpanes class="default-theme">
                    <splitpane size="65" style={{ flex: 1 }}>
                        {this.renderItems()}
                    </splitpane>
                </splitpanes>
            </div>
        );
    }
};
</script>

<style lang="stylus" scoped>
@import '../../../../styles/imports';

.operation {
    display: flex;
    justify-content: left;
    align-items: center;

    a {
        color: $primary-color;
    }
}

.ii-event-record {
    height: 100%;
    width: 100%;
    overflow: hidden;
}
</style>