app.controller("account-ctrl", function($scope, $http) {
	$scope.items = [];
	$scope.cates = [];
	$scope.form = {};
	$scope.field = [];
	$scope.error = ['err'];
	
	$scope.email = {
		text: 'me@example.com'
	};

	$scope.initialize = function() {
		// Load products
		$http.get("/rest/accounts/all").then(resp => {
			$scope.items = resp.data;
			$scope.items.forEach(item => {
				item.date = new Date(item.date)
			})
		});

	}
	$scope.$watch('searchText', function(term) {
		$scope.filtered = filterFilter($scope.items, term);
		$scope.size = $scope.filtered.length;
		$scope.noOfPages = Math.ceil($scope.filtered.length / $scope.entryLimit);
	}, true);

$scope.sort = function(keyname) {
		$scope.sortKey = keyname;
		$scope.reverse = !$scope.reverse;
	}
	// Khởi đầu
	$scope.initialize();

	// Xóa form
	$scope.reset = function() {
		$scope.error = ['err'];
		$scope.form = {
			photo: 'cloud-upload.jpg',
		};
		$('#id').attr('readonly', false);
		$('#btn-create').removeAttr('disabled');
		$('#btn-update').attr('disabled', 'disabled');
		$('#btn-delete').attr('disabled', 'disabled');
	}

	// Hiện thị lên form
	$scope.edit = function(item) {
		$scope.form = angular.copy(item);
		/*window.scrollTo(0, document.body.scrollHeight);*/

		$('#btn-create').attr('disabled', 'disabled');
		$('#btn-delete').removeAttr('disabled');
		$('#btn-update').removeAttr('disabled');
		$('html,body').animate({
			scrollTop: $(".info").offset().top
		},
			'slow');
	}



	// Thêm sản phẩm mới
	$scope.create = function() {
		var item = angular.copy($scope.form);
		$http.post(`/rest/accounts`, item).then(resp => {
			resp.data.date = new Date(resp.data.date)
			$scope.items.push(resp.data);
			$scope.reset();
			alert("Thêm tài khoản thành công!");
		}).catch(error => {
			alert("Lỗi thêm mới tài khoản");
			console.log("Error", error);
		});
	}

	// cặp nhật sản phẩm
	$scope.update = function() {
		var item = angular.copy($scope.form);
		$http.put(`/rest/accounts/${item.id}`, item).then(resp => {
			var index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items[index] = item;
			alert("Cập nhật tài khoản thành công!");
		})
			.catch(error => {
				alert("Lỗi cập nhật tài khoản");
				console.log("Error", error);
			});
	}

	// Xóa sản phẩm 
	$scope.delete = function(item) {
		$http.delete(`/rest/accounts/${item.id}`).then(resp => {
			var index = $scope.items.findIndex(p => p.id == item.id);
			$scope.items.splice(index, 1);
			$scope.reset();
			alert("Xóa tài khoản thành công!");
		})
			.catch(error => {
				alert("Lỗi Xóa tài khoản");
				console.log("Error", error);
			});
	}

	// Upload hình
	$scope.imageChanged = function(files) {
		var data = new FormData();
		data.append('file', files[0]);
		$http.post('/rest/upload/images', data, {
			transformRequest: angular.identity,
			headers: { 'Content-Type': undefined }
		}).then(resp => {
			$scope.form.photo = resp.data.name;
		}).catch(error => {
			alert("Lỗi upload hình ảnh");
			console.log("Error", error);
		})
	}

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
	/*$(document).ready(function() {
		$("#example1").DataTable({
			"responsive": true,
			"lengthChange": false,
			"autoWidth": false,
			"paging": true,
			"searching": false,
			"ordering": true,
			"info": true,
			"buttons": ["copy", "csv", "excel", "pdf", "print", "colvis"]
	}*/

	/*	$scope.propertyName = 'username';
		$scope.reverse = true;
		$scope.example1 = $scope.items;
	
		$scope.sortBy = function(propertyName) {
			$scope.reverse = ($scope.propertyName === propertyName) ? !$scope.reverse : false;
			$scope.propertyName = propertyName;
		};
	*/
/*	$(function() {
		$("#example1").DataTable({
			"ajax": {
				"url": "/rest/accounts",
				"dataSrc": ""
			},
			"columns": [
				{ "data": "id" },
				{ "data": "photo" },
				{ "data": "username" },
				{ "data": "password" },
				{ "data": "fullname" },
				{ "data": "email" },
				{
					"data": null,
					"render": function(data, type, row) {
						return '<button  class="btn btn-success" ng-click="edit(' + row.id + ')">Xem chi tiết</button>';
					}
				}, 

				// Add more column configurations as needed
			],
			"responsive": true, "lengthChange": false, "autoWidth": false,
		}).buttons().container().appendTo('#example1_wrapper .col-md-6:eq(0)');
	});*/
// Trong AngularJS controller hoặc service
	$scope.exportExcel = function() {
		$http.get('/print-to-excel', { responseType: 'arraybuffer' })
			.then(function(response) {
				var blob = new Blob([response.data], { type: 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet' });
				var link = document.createElement('a');
				link.href = window.URL.createObjectURL(blob);
				link.download = 'example.xlsx';
				link.click();
			})
			.catch(function(error) {
				console.error('Error exporting Excel:', error);
			});
	};

	$scope.exportPdf = function() {
		$http.get('/print-to-pdf', { responseType: 'arraybuffer' })
			.then(function(response) {
				var blob = new Blob([response.data], { type: 'application/pdf' });
				var objectUrl = URL.createObjectURL(blob);
				var a = document.createElement('a');
				a.href = objectUrl;
				a.download = 'exportAccount.pdf';
				a.click();
				URL.revokeObjectURL(objectUrl);
			})
			.catch(function(error) {
				console.error('Error exporting PDF:', error);
			});
	};
	
});

	

	