<html>
<head>
<link href="//unpkg.com/element-ui@2.4.9/lib/theme-chalk/index.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script src="//unpkg.com/vue/dist/vue.js"></script>
<script src="//cdn.bootcss.com/vue-resource/1.0.3/vue-resource.js" type="text/javascript" charset="utf-8"></script>
<script src="//unpkg.com/element-ui@2.4.9/lib/index.js"></script>
<div id="app">
<section class="el-container">
<aside class="el-aside menu" style="width: 300px;">
<el-row class="tac">
  <el-col :span="12">
    <el-menu default-active="2" class="el-menu-vertical-demo" @open="handleOpen" @close="handleClose">
      <el-submenu index="1">
        <template slot="title">
          <i class="el-icon-location"></i>
          <span>导航一</span>
        </template>
        <el-menu-item-group>
          <template slot="title">分组一</template>
          <el-menu-item index="1-1">选项1</el-menu-item>
          <el-menu-item index="1-2">选项2</el-menu-item>
        </el-menu-item-group>
        <el-menu-item-group title="分组2">
          <el-menu-item index="1-3">选项3</el-menu-item>
        </el-menu-item-group>
        <el-submenu index="1-4">
          <template slot="title">选项4</template>
          <el-menu-item index="1-4-1">选项1</el-menu-item>
        </el-submenu>
      </el-submenu>
      <el-menu-item index="2">
        <i class="el-icon-menu"></i>
        <span slot="title">导航二</span>
      </el-menu-item>
      <el-menu-item index="3" disabled>
        <i class="el-icon-document"></i>
        <span slot="title">导航三</span>
      </el-menu-item>
      <el-menu-item index="4">
        <i class="el-icon-setting"></i>
        <span slot="title">导航四</span>
      </el-menu-item>
    </el-menu>
  </el-col>
</el-row>
</aside>
<main class="el-main content">
<el-breadcrumb separator="/">
  <el-breadcrumb-item :to="{ path: '/' }">资源管理</el-breadcrumb-item>
  <el-breadcrumb-item><a href="/">课件管理</a></el-breadcrumb-item>
  <el-breadcrumb-item>课件列表</el-breadcrumb-item>
</el-breadcrumb>

<el-form :inline="true" :model="courseware" class="demo-form-inline" style="margin-top:30px">
  <el-form-item label="课件名称">
    <el-input v-model="courseware.name" placeholder="课件名称"></el-input>
  </el-form-item>
  <el-form-item label="课件编号">
    <el-input v-model="courseware.number" placeholder="课件编号"></el-input>
  </el-form-item>
  <el-form-item label="关键字">
    <el-input v-model="courseware.keyword" placeholder="关键字"></el-input>
  </el-form-item>
  <el-form-item label="课件类型">
    <el-select v-model="courseware.type" placeholder="课件类型">
      <el-option label="SK标准" value="sk"></el-option>
      <el-option label="SCORM课件" value="scorm"></el-option>
    </el-select>
  </el-form-item>
  <el-form-item>
  	<el-checkbox v-model="checked">不含子目录</el-checkbox>
  </el-form-item>
  <el-form-item>
    <el-button type="primary" @click="onSubmit">查询</el-button>
  </el-form-item>
</el-form>

<template>
  <el-table :data="tableData" style="width: 100%">
    <el-table-column prop="number" label="课件编号" width="180">
    </el-table-column>
    <el-table-column label="课件名称" width="180">
      <template slot-scope="scope">
        <el-popover trigger="hover" placement="top">
          <p>编号: {{ scope.row.number }}</p>
          <p>名称: {{ scope.row.name }}</p>
          <div slot="reference" class="name-wrapper">
            <el-tag size="medium">{{ scope.row.name }}</el-tag>
          </div>
        </el-popover>
      </template>
    </el-table-column>
    <el-table-column prop="keyword" label="关键字" width="180">
    </el-table-column>
    <el-table-column label="学习时间(分钟)" width="180">
      <template slot-scope="scope">
        <i class="el-icon-time"></i>
        <span style="margin-left: 10px">{{ scope.row.time }}</span>
      </template>
    </el-table-column>
    <el-table-column prop="type" label="课件类型" width="180">
    </el-table-column>
    <el-table-column label="操作" width="180">
      <template slot-scope="scope">
        <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
        <el-button size="mini" type="danger" @click="handleDelete(scope.$index, scope.row)">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
  <el-pagination background
            @size-change="handleSizeChange"
            @current-change="handleCurrentChange"
            :current-page="currentPage"
            :page-sizes="[10, 50, 100, 200]"
            :page-size="pageSize"
            layout="total, sizes, prev, pager, next, jumper"
            :total="total">
        </el-pagination>
</template>


</main>
</section>
</div>
</body>
</html>
<script>
var Main = {
	    data(){
	      return {
	    	getListUrl: "http://localhost:8767/coursemanager/list",
	    	total: 5,
            currentPage: 1,
　　　　　　　 	pageSize: 10,
        	checked: true,
　　　　　　　 	courseware: {
　　　　　　         	 	name: '',
　　　　　　            	number: '',
                keyword: ''
　　　　　　           },
	        tableData: [{
	          number: '001',
	          name: '课件1',
	          time: '20',
	          keyword: '关键字1',
	          type: 'sk'
	        }, {
	        	number: '002',
		          name: '课件2',
		          time: '20',
		          keyword: '关键字2',
		          type: 'sk'
	        }, {
	        	number: '003',
		          name: '课件3',
		          time: '30',
		          keyword: '关键字3',
		          type: 'sk'
	        }, {
	        	number: '004',
		          name: '课件4',
		          time: '40',
		          keyword: '关键字4',
		          type: 'sk'
	        }]
	      }
	    },
	    created: function(){
            // 组件创建完后获取数据，
            // 此时 data 已经被 observed 了
            this.fetchData();
        },
        methods: {
            toggleSelection(rows) {
                if (rows) {
                    rows.forEach(function(row)  {
                        this.$refs.multipleTable.toggleRowSelection(row);
                    });
                } else {
                    this.$refs.multipleTable.clearSelection();
                }
            },
            handleSelectionChange(val) {
                this.multipleSelection = val;
            },
            callbackFunction(result) {
                alert(result + "aaa");
            },
            handleSizeChange(val){
              this.pageSize = val;
              this.currentPage = 1;
            },
            handleCurrentChange(val){
              this.currentPage = val;
            },
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
              handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            onSubmit() {
                console.log('submit!');
            },
            fetchData(){ //获取数据
            	var that = this;
            	this.$http.jsonp(that.getListUrl ,{//跨域请求数据
            		method: 'GET',
                    params: {
                        keyword:'s'//输入的关键词
                    }
                    //jsonpCallback:'callbackFunction'//这里是callback
                  }).then(function(res) {//请求成功回调，请求来的数据赋给searchList数组
                    this.total = res.body.count;
                    this.currentPage = res.body.curr;
                    this.tableData = res.body.data;
                    console.info(res);
                  },function(res) {//失败显示状态码
                    alert("res.status:"+res.status)
                  })
            }
        }
}
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')
</script>