app.controller("order-ctrl", function($scope, $http) {
	$scope.items = [];
	$scope.cates = [];
	$scope.items2 = [];
	$scope.form = {};

	$scope.initialize = function() {
		// Load products
		$http.get("/rest/orders").then(resp => {
			$scope.items = resp.data;
			$scope.items.forEach(item => {
				item.date = new Date(item.date)
			})
		});

		// Load states
		$http.get("/rest/states").then(resp => {
			$scope.cates = resp.data;
		});

	}

	// Khởi đầu
	$scope.initialize();

	$scope.propertyName = 'date';
	$scope.reverse = true;
	$scope.example1 = $scope.items;

	$scope.sort = function(propertyName) {
		$scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
		$scope.propertyName = propertyName;
	};

	// Xóa form
	/*$scope.reset = function(){
		$scope.form = {
			publication_date:new Date(),
			image:'cloud-upload.jpg',
			available:true,
		};
	}
	*/
	// Hiện thị lên form
	$scope.edit = function(item) {
		$http.get("/rest/orderdetails/" + item.id).then(resp => {
			$scope.items2 = resp.data;
		});

		$scope.form = angular.copy(item);
		$('html,body').animate({
			scrollTop: $(".info").offset().top
		},
			'slow');

	}

	// Thêm sản phẩm mới
	/*$scope.create = function(){
		var item = angular.copy($scope.form);
		$http.post(`/rest/products`,item).then(resp =>{
			resp.data.publication_date = new Date(resp.data.publication_date)
			$scope.items.push(resp.data);
			$scope.reset();
			alert("Thêm sản phẩm thành công!");
		}).catch(error =>{
			alert("Lỗi thêm mới sản phẩm");
			console.log("Error",error);
		});
	}*/

	// cập nhật sản phẩm
	$scope.update = function(){
		var item = angular.copy($scope.form);
		$http.put(`/rest/orders/${item.id}`,item).then(resp =>{
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
	$scope.delete = function(item) {
		$http.delete(`/rest/orders/${item.id}`).then(resp => {
			var index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items.splice(index, 1);
			$scope.reset();
			alert("Xóa thành công!");
		})
			.catch(error => {
				alert("Lỗi xóa");
				console.log("Error", error);
			});
	}

	// Upload hình
	/*$scope.imageChanged = function(files){
		var data = new FormData();
		data.append('file',files[0]);
		$http.post('/rest/upload/images',data,{
			transformRequest:angular.identity,
			headers:{'Content-Type':undefined}
		}).then(resp =>{
			$scope.form.image = resp.data.name;
		}).catch(error =>{
			alert("Lỗi upload hình ảnh");
			console.log("Error",error);
		})
	}*/

	$scope.pager = {
		page: 0,
		size: 10,
		get items() {
			var start = this.page * this.size;
			return $scope.items.slice(start, start + this.size);
		},
		get count() {
			return Math.ceil(1.0 * $scope.items.length / this.size);
		},
		first() {
			this.page = 0;
		},
		prev() {
			this.page--;
			if (this.page < 0) {
				this.last();
			}
		},
		next() {
			this.page++;
			if (this.page > this.count) {
				this.first();
			}
		},
		last() {
			this.page = this.count - 1;
		}
	}
});