package kr.icia.service;

import java.util.List;

import kr.icia.domain.CartVO;

public interface CartService {

   public void insert(CartVO vo);
   
   public List<CartVO> listCart(String userid);
   
   public void delete(int cartid);
   
   public void modifyCart(CartVO vo);
   
   public int sumMoney(String userid);
   
   public int countCart(int productid,String userid);
   
   public void updateCart(CartVO vo);
}