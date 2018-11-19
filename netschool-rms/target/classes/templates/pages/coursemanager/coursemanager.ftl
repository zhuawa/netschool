<html>
<head>
<link href="//unpkg.com/element-ui@2.4.9/lib/theme-chalk/index.css" rel="stylesheet" type="text/css" />
</head>
<body>
<script src="//unpkg.com/vue/dist/vue.js"></script>
<script src="//cdn.bootcss.com/vue-resource/1.0.3/vue-resource.js" type="text/javascript" charset="utf-8"></script>
<script src="//unpkg.com/element-ui@2.4.9/lib/index.js"></script>
<section class="el-container">
<aside class="el-aside menu" style="width: 300px;">
<div id="dirtree">
<el-tree :data="data5" show-checkbox="" node-key="id" ref="tree" default-expand-all :expand-on-click-node="false">
      <span class="custom-tree-node" slot-scope="{ node, data }">
        <span>{{ node.label }}</span>
        <span :class="{'hiddenbutton':hiddenbutton}">
          <el-button type="text" size="mini" @click="() => adddir(data)">
            	<img src="../static/add.png"/>
          </el-button>
          <el-button type="text" size="mini" @click="() => remove(node, data)">
            	<img src="../static/delete.png"/>
          </el-button>
        </span>
      </span>
</el-tree>
<el-dialog title="目录维护" :visible.sync="dialogDirVisible">
  <el-form :model="dirform">
    <el-form-item label="目录名称" >
      <el-input v-model="dirform.name" autocomplete="off"></el-input>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="dialogDirVisible = false">取 消</el-button>
    <el-button type="primary" @click="add">确 定</el-button>
  </div>
</el-dialog>
</div>
</aside>
<main class="el-main content">
<div id="app">
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
<el-button type="primary" @click="handleAddResources">导入</el-button>
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
<template>
<el-dialog title="课件" :visible.sync="dialogTableVisible">
  <el-form :model="form">
    <el-form-item label="课件名称" :label-width="formLabelWidth">
      <el-input v-model="form.name" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="关键字" :label-width="formLabelWidth">
      <el-input v-model="form.keyword" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="学习时间(分钟)" :label-width="formLabelWidth">
      <el-input v-model="form.time" autocomplete="off"></el-input>
    </el-form-item>
    <el-form-item label="课件类型" :label-width="formLabelWidth">
      <el-select v-model="form.type" placeholder="请选择课件类型">
        <el-option label="SK标准" value="sk"></el-option>
        <el-option label="SCORM课件" value="scorm"></el-option>
      </el-select>
    </el-form-item>
  </el-form>
  <div slot="footer" class="dialog-footer">
    <el-button @click="dialogTableVisible = false">取 消</el-button>
    <el-button type="primary" @click="dialogTableVisible = false">确 定</el-button>
  </div>
</el-dialog>
</template>
</div>
</main>
</section>

</body>
</html>
<script>
var dirtree = new Vue({
	el:"#dirtree",
	data(){
	const treeData = [{
        	id: 1,
        	label: '一级 1',
        	children: [{
          	id: 4,
          	label: '二级 1-1',
          	children: [{
            	id: 9,
            	label: '三级 1-1-1'
          	}, {
            	id: 10,
            	label: '三级 1-1-2'
          	}]
        	}]
      		}, {
        	id: 2,
        	label: '一级 2',
        	children: [{
          		id: 5,
          		label: '二级 2-1'
        	}, {
          		id: 6,
          		label: '二级 2-2'
        		}]
      		}, {
        		id: 3,
        		label: '一级 3',
        	children: [{
          		id: 7,
          		label: '二级 3-1'
        	}, {
          	id: 8,
          	label: '二级 3-2'
        	}]
      	}];
		return {
			data5: JSON.parse(JSON.stringify(treeData)),
	      	dialogDirVisible: false,
	      	hiddenbutton:false,
			dirform:{
				name: ''
			},
			parentId:'',
			parentTreeNodeId:''
		}
	},
	      	methods: {
      		adddir(data){
      			var currentId = data.id;
      			var currentTreeNodeId = data.$treeNodeId;
      			this.parentTreeNodeId = currentTreeNodeId;
      			this.parentId = currentId;
      			var keys = this.$refs.tree.getCheckedKeys();
      			id++;
      			keys[keys.length] = id;
        		this.dialogDirVisible = true;
      		},
      		add(){
      			const newChild = { id: id, label: this.dirform.name, children: []};
      			var data = this.$refs.tree.getCurrentNode();
      			if (!data.children) {
          			this.$set(data, 'children', []);
        		}
      			this.$refs.tree.append(newChild,this.parentId);
      			this.dialogDirVisible = false;
      			this.dirform.name = '';
      		},
      		remove(node, data) {
        		const parent = node.parent;
        		const children = parent.data.children || parent.data;
        		const index = children.findIndex(d => d.id === data.id);
        		children.splice(index, 1);
      		}
      		}
});
let id = 1000;

var Main = {
	    data(){
	      return {
	      	formLabelWidth: '120px',
	    	getListUrl: "http://localhost:8767/coursemanager/list",
	    	total: 50,
            currentPage: 1,
　　　　　　　 	pageSize: 10,
        	checked: true,
　　　　　　　 	courseware: {
　　　　　　         	 	name: '',
　　　　　　            	number: '',
                keyword: ''
　　　　　　               },
			dialogTableVisible: false,
			form: {
				name: '',
				keyword: '',
				time: '',
				type: ''
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
              this.fetchData();
            },
            handleCurrentChange(val){
              this.currentPage = val;
              this.fetchData();
            },
            handleOpen(key, keyPath) {
                console.log(key, keyPath);
            },
              handleClose(key, keyPath) {
                console.log(key, keyPath);
            },
            handleAddResources(){
            	this.form = {
				name: '',
				keyword: '',
				time: '',
				type: ''
			}
            	this.dialogTableVisible = !this.dialogTableVisible;
            },
            handleEdit(index, row){
            	this.dialogTableVisible = true;
            	this.form = row;
            	console.log(index);
            },
            handleDelete(index, row){
            	this.tableData.splice(index, 1);
            },
            onSubmit() {
                console.log('submit!');
            },
            fetchData(){ //获取数据
            	var that = this;
            	this.$http.get(that.getListUrl,{params:{keyword:that.form.keyword,pageNum:that.currentPage, pageSize:that.pageSize}}).then(function (resp) {
                    that.tableData = resp.data.data;
                }, function (error) {
                    alert("error");
                });
            	/* this.$http.jsonp(that.getListUrl ,{//跨域请求数据
            		method: 'GET',
                    params: {
                        keyword:'s',//输入的关键词
                        pageNum: that.currentPage,
                        pageSize: that.pageSize
                    }
                    //jsonpCallback:'callbackFunction'//这里是callback
                  }).then(function(res) {//请求成功回调，请求来的数据赋给searchList数组
                    this.total = res.body.count;
                    this.currentPage = res.body.curr;
                    this.tableData = res.body.data;
                    console.info(res);
                  },function(res) {//失败显示状态码
                    alert("res.status:"+res.status)
                  }) */
            }
        }
}
var Ctor = Vue.extend(Main)
new Ctor().$mount('#app')
</script>