package com.popup.project.cart.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.popup.project.cart.model.CartItem;

import jakarta.servlet.http.HttpSession;

@Controller
@RequestMapping("/cart")
public class CartController {

    @GetMapping
    public String viewCart(Model model, HttpSession session) {
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }

        model.addAttribute("cartItems", cartItems);
        return "cartPage";
    }

    @PostMapping("/add")
    public String addToCart(@RequestParam String productName, @RequestParam int price, @RequestParam int quantity, HttpSession session) {
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }

        cartItems.add(new CartItem(productName, price, quantity));
        return "redirect:/cart";
    }

    @PostMapping("/buy")
    public String buyNow(@RequestParam String productName, @RequestParam int price, @RequestParam int quantity, HttpSession session) {
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems == null) {
            cartItems = new ArrayList<>();
            session.setAttribute("cartItems", cartItems);
        }

        cartItems.add(new CartItem(productName, price, quantity));
        return "redirect:/checkout";
    }

    @DeleteMapping("/remove/{index}")
    public ResponseEntity<Void> removeItem(@PathVariable int index, HttpSession session) {
        List<CartItem> cartItems = (List<CartItem>) session.getAttribute("cartItems");
        if (cartItems != null && index >= 0 && index < cartItems.size()) {
            cartItems.remove(index);
        }
        return ResponseEntity.ok().build();
    }
}
