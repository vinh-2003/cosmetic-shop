package com.cosmeticshop.cosmetic_shop.controller.user;

import com.cosmeticshop.cosmetic_shop.entity.Cart;
import com.cosmeticshop.cosmetic_shop.entity.CartItem;
import com.cosmeticshop.cosmetic_shop.entity.Category;
import com.cosmeticshop.cosmetic_shop.entity.User;
import com.cosmeticshop.cosmetic_shop.service.CartService;
import com.cosmeticshop.cosmetic_shop.service.CategoryService;
import com.cosmeticshop.cosmetic_shop.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.math.BigDecimal;
import java.security.Principal;
import java.util.List;

@Controller
@RequestMapping("/cart")
public class CartUserController {

    @Autowired
    private UserService userService;

    @Autowired
    private CategoryService categoryService;

    @Autowired
    private CartService cartService;

    @GetMapping
    public String getCart(Model model) {

        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String username = userDetails.getUsername();

        User user = userService.findByUsername(username);

        Cart cart = user.getCart();

        BigDecimal totalPrice = BigDecimal.ZERO;
        for (CartItem cartItem : cart.getCartItems()) {
            totalPrice = totalPrice.add(cartItem.getPrice().multiply(new BigDecimal(cartItem.getQuantity())));
        }

        model.addAttribute("cart", cart);
        model.addAttribute("totalPrice", totalPrice);

        return "cart";
    }

    @PostMapping("/add")
    public String addProductToCart(@RequestParam("productId") Long productId,
                                   @RequestParam("quantity") int quantity,
                                   Principal principal, RedirectAttributes redirectAttributes) {
        // Lấy thông tin người dùng hiện tại
        User user = userService.findByUsername(principal.getName());

        // Thêm sản phẩm vào giỏ hàng
        cartService.addProductToCart(user, productId, quantity);

        // Thông báo thành công và chuyển hướng lại trang sản phẩm
        redirectAttributes.addFlashAttribute("successMessage", "Product added to cart successfully!");
        return "redirect:/products/" + productId;
    }

    @PostMapping("/remove")
    public String removeCartItem(@RequestParam("cartItemId") Long cartItemId, Model model) {
        // Lấy giỏ hàng của người dùng
        UserDetails userDetails = (UserDetails) SecurityContextHolder.getContext().getAuthentication().getPrincipal();

        String username = userDetails.getUsername();

        User user = userService.findByUsername(username);

        Cart cart = user.getCart();

        // Xóa sản phẩm khỏi giỏ hàng
        cartService.removeCartItem(cartItemId, cart);

        // Tính tổng tiền lại sau khi xóa
        BigDecimal totalPrice = BigDecimal.ZERO;
        for (CartItem item : cart.getCartItems()) {
            totalPrice = totalPrice.add(item.getPrice().multiply(new BigDecimal(item.getQuantity())));
        }

        // Cập nhật lại model với giỏ hàng mới và tổng tiền
        model.addAttribute("cart", cart);
        model.addAttribute("totalPrice", totalPrice);

        return "redirect:/cart";  // Điều hướng trở lại trang giỏ hàng
    }
}
