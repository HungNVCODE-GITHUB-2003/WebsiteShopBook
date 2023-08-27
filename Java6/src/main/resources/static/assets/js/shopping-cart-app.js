const app = angular.module("shopping-cart-app", []);

app.controller("shopping-cart-ctrl", function($scope, $http) {

	// QUẢN LÝ GIỎ HÀNG

	$scope.cart = {
		items: [],

		// thêm sp vào giỏ hàng
		add(Id) {
			console.log(Id);

			var item = this.items.find(item => item.id == Id);
			if (item) {
				item.qty++;
				this.saveToLocalStorage();
			}
			else {
				$http.get(`/rest/products/${Id}`).then(resp => {
					resp.data.qty = 1;
					this.items.push(resp.data);
					this.saveToLocalStorage();
				})
			}
		},


		// Xóa sp khỏi giỏ hàng
		remove(id) {
			var index = -1;
			for (var i = 0; i < this.items.length; i++) {
				if (this.items[i].id === id) {
					index = i;
					break;
				}
			}
			if (index !== -1) {
				this.items.splice(index, 1);
				this.saveToLocalStorage();
			}
		},
		// Xóa sạch các mặt hàng trong giỏ
		clear() {
			this.items = []
			this.saveToLocalStorage();
		},



		// Tính tổng số lượng các mặt hàng trong giỏ
		get count() {
			return this.items
				.map(item => item.qty)
				.reduce((total, qty) => total += qty, 0);
		},

		// tổng thành tiền các mặt hàng trong giỏ
		get amount() {
			return this.items
				.map(item => item.qty * item.price)
				.reduce((total, qty) => total += qty, 0);
		},

		// Lưu giỏ hàng vào trong Local storage
		saveToLocalStorage() {
			var json = JSON.stringify(angular.copy(this.items));
			localStorage.setItem("cart", json);
		},

		// Đọc giỏ hàng từ local storage
		loadFromLocalStorage() {
			try {
				var json = localStorage.getItem("cart");
				this.items = json ? JSON.parse(json) : [];
			} catch (error) {
				console.error("Error loading cart from localStorage:", error);
				this.items = [];
			}

		}
	}

	$scope.cart.loadFromLocalStorage();


	$scope.order = {
		date: new Date(),
		address: "",
		account: { id: $("#account_id").text() },
		state: {id: 1},
		get orderDetail() {
			return $scope.cart.items.map(item => {
				return {
					id: item.id,
					book: { id: item.id },
					price: item.price,
					quantity: item.qty
				}
			});
		},
		purchase() {
			var order = angular.copy(this);
			// Thực hiện đặt hàng
			$http.post("/rest/orders/add", order).then(resp => {
				alert("Đặt hàng thành công!");
				$scope.cart.clear();
				location.href = "/order/detail/" + resp.data.id;
			}).catch(error => {
				alert("Đặt hàng lỗi!");
				console.log(error)
			})
		}
	}

	$scope.showMiniCart = false; // Biến kiểm soát hiển thị giỏ hàng mở rộng

	// Các hàm và code khác của controller ở đây...

	// Function to display or hide the mini cart
	$scope.toggleMiniCart = function(event) {
		if (event) {
			event.stopPropagation(); // Ngăn chặn sự kiện lan toả đến window.onclick
		}
		$scope.showMiniCart = !$scope.showMiniCart;
	};

	// Close the modal when the document is clicked outside the modal
	window.onclick = function(event) {
		var miniCart = document.getElementById("miniCart");
		if (event.target === miniCart) {
			$scope.$apply(function() {
				$scope.showMiniCart = false;
			});
		}
	};

	//  ---------Active menu------------ 

	// Hàm kiểm tra li có được active hay không
	/*$scope.isActive = function(viewLocation) {
		return viewLocation === $location.path();
	};*/
});

