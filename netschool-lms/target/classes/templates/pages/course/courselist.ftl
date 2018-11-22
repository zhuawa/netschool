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
            	<img src="../../static/add.png"/>
          </el-button>
          <el-button type="text" size="mini" @click="() => remove(node, data)">
            	<img src="../../static/delete.png"/>
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

<vue-waterfall-easy :imgsArr="imgsArr" @scrollLoadImg="fetchImgsData"></vue-waterfall-easy>

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
        	label: '增值税课件目录',
        	children: [{
          	id: 4,
          	label: '增值税一般课件目录',
          	children: [{
            	id: 9,
            	label: '减免税课件'
          	}, {
            	id: 10,
            	label: '小规模课件'
          	}]
        	}]
      		}, {
        	id: 2,
        	label: '印花税课件目录',
        	children: [{
          		id: 5,
          		label: '印花税培训课件'
        	}, {
          		id: 6,
          		label: '总结课件'
        		}]
      		}, {
        		id: 3,
        		label: '所得税课件目录',
        	children: [{
          		id: 7,
          		label: '个人所得税课件'
        	}, {
          		id: 8,
          		label: '企业所得税课件'
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
	    	getListUrl: "http://localhost:8777/coursecenter/list",
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