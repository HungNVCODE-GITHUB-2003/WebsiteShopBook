app.controller("genres-ctrl", function($scope, $http) {
	$scope.items = [];
	$scope.cates = [];
	$scope.form = {};
	
	$scope.initialize = function(){
		// Load genres
		$http.get("/rest/categories").then(resp =>{
			$scope.items = resp.data;
			
		});
		
		
			
	}
	
	// Khởi đầu
	$scope.initialize();
	
	// Xóa form
	$scope.reset = function(){
		$scope.form = {
			
		};
	}
	
	// Hiện thị lên form
	$scope.edit = function(item){
		$scope.form = angular.copy(item);
		$(".nav-tabs a:eq(0)").tab('show')
	}
	
	// Thêm sản phẩm mới
	$scope.create = function(){
		var item = angular.copy($scope.form);
		$http.post(`/rest/categories`,item).then(resp =>{
			$scope.items.push(resp.data);
			$scope.reset();
			alert("Thêm sản phẩm thành công!");
		}).catch(error =>{
			alert("Lỗi thêm mới sản phẩm");
			console.log("Error",error);
		});
	}
	
	// cặp nhật sản phẩm
	$scope.update = function(){
		var item = angular.copy($scope.form);
		$http.put(`/rest/categories/${item.id}`,item).then(resp =>{
			var index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items[index] = item;				
			alert("Cập nhật sản phẩm thành công!");
		})
		.catch(error =>{
			alert("Lỗi cập nhật sản phẩm");
			console.log("Error",error);
		});
	}
	
	// Xóa sản phẩm 
	$scope.delete = function(item){
		$http.delete(`/rest/categories/${item.id}`).then(resp =>{
			var index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items.splice(index,1);
			$scope.reset();				
			alert("Xóa sản phẩm thành công!");
		})
		.catch(error =>{
			alert("Lỗi Xóa sản phẩm");
			console.log("Error",error);
		});
	}
	
	
	
	$scope.pager = {
		page:0,
		size:10,
		get items(){
			var start = this.page*this.size;
			 return $scope.items.slice(start,start + this.size);
		},
		get count(){
			return Math.ceil(1.0 * $scope.items.length / this.size);
		},
		first(){
			this.page = 0;
		},
		prev(){
			this.page--;
			if(this.page < 0){
				this.last();
			}
		},
		next(){
			this.page++;
			if(this.page > this.count){
				this.first();
			}
		},
		last(){
			this.page = this.count-1;
		}		
	}
});