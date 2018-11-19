<template>
<div id="resourcesForm">
<el-dialog title="收货地址" :visible.sync="dialogTableVisible">
  <el-table :data="gridData">
    <el-table-column property="date" label="日期" width="150"></el-table-column>
    <el-table-column property="name" label="姓名" width="200"></el-table-column>
    <el-table-column property="address" label="地址"></el-table-column>
  </el-table>
</el-dialog>
</div>
</template>
<script>
export default {
	data:function(){
		return {
			dialogTableVisible : true,
			gridData: {
				date:'s',
				name:'s',
				address:'s'
			}
		}
	},
	props:{
            show:Boolean
    },
    watch:{
    	dialogTableVisible: function(val, old){
    		const self=this;
    		self.dialogTableVisible = self.show;
    	}
    },
    methods:{
    	handleClick:function(){
    		alert(this.show);
    	}
    }
}
</script>