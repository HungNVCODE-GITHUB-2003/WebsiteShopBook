package com.poly.controller;

import java.util.List;





import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.poly.bean.Book;
import com.poly.dao.AccountDAO;
import com.poly.dao.BookDAO;
import com.poly.dao.WishlistDAO;



@Controller
public class HomeController {

 
//	@RequestMapping({"/","/home/index"})
//	public String Home(Model model) {
//		return "user/index";
//	}
	
	@Autowired
	private final BookDAO booksdao;
	
	@Autowired
	AccountDAO acdao;

	@Autowired
	private final WishlistDAO wishlistsdao;

	public HomeController(BookDAO booksdao, WishlistDAO wishlistsdao) {
		this.booksdao = booksdao;
		this.wishlistsdao = wishlistsdao;
	}

	
	
	@RequestMapping({"/","/home/index"})
	public String Home(Model model) {
		List<Book> books = booksdao.findAll();
		
		 // Lấy thông tin người dùng đã xác thực từ SecurityContextHolder
//        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
//
//        // Kiểm tra nếu người dùng đã xác thực
//        if (authentication.isAuthenticated()) {
//            // Lấy tên người dùng
//            String username = authentication.getName();
//
//            // Lấy các quyền (roles) của người dùng
//            String roles = authentication.getAuthorities().toString();
//
//            // Trả về thông tin tài khoản trong phản hồi
//            System.out.println("Xin chào, " + username + "! Bạn có các quyền: " + roles);
//        } else {
//        	System.out.println("Xin chào! Bạn chưa đăng nhập.");
//        }
//        String username = authentication.getName();
//        Account ac = acdao.findByUsername(username);
//        System.out.println(ac.getUsername());
//        System.out.println(ac.getAddress());
//        System.out.println(ac.getFullname());
//        System.out.println(ac.getPassword());
//        System.out.println(ac.getPhone());
//        System.out.println(ac.getPhoto());
//        System.out.println("*************************************************************************?///////////////////////");
//    System.out.println(ac.getAccountroles().stream().map(er -> er.getRole().getName()).collect(Collectors.toList())); 
		model.addAttribute("books", books);
		return "user/index";
	}
	

	

	@GetMapping("/index/product-detail/{productId}")
	public String getProductDetail(@PathVariable String productId, Model model) {
		// Fetch the specific product based on the given productId
		Book books = booksdao.findById(productId).orElse(null);
		if (books == null) {
			// Handle the case when the product is not found (optional)
			return "redirect:/index"; // Redirect to the home page or an error page
		}

		// Add the product to the model to be displayed in the modal box or product
		// detail page
		model.addAttribute("productDetails", books);
		return "product/product_detail"; // Replace with the actual Thymeleaf template for the modal content
	}



	@RequestMapping({ "/admin", "/admin/home/index" })
	public String admin() {
		return "redirect:/assets/admin/index.html";
	}

}
