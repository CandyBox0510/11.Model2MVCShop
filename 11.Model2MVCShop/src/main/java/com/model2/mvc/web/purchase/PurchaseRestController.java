package com.model2.mvc.web.purchase;

import java.util.HashMap;
import java.util.List;
import java.util.Map;


import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.Purchase;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.domain.Wish;
import com.model2.mvc.service.product.ProductService;
import com.model2.mvc.service.purchase.PurchaseService;
import com.model2.mvc.service.user.UserService;
import com.model2.mvc.service.user.impl.UserServiceImpl;

@RestController
@RequestMapping("/purchase/*")
public class PurchaseRestController {
	
	@Autowired
	@Qualifier("purchaseServiceImpl")
	PurchaseService purchaseService;
	
	@Autowired
	@Qualifier("productServiceImpl")
	ProductService productService;
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	public PurchaseRestController() {
		System.out.println("PurchaseController() default Constructor");
	}
	
	@RequestMapping(value="/json/addPurchase", method=RequestMethod.POST)
	public void addPurchase(@RequestParam("purchase") String jsonPurchase,
								@RequestParam("file")MultipartFile fileName
							) throws Exception{

		ObjectMapper objectMapper = new ObjectMapper();
		Purchase purchase = (Purchase)objectMapper.readValue(jsonPurchase, Purchase.class);
		System.out.println("여까지");
		System.out.println("addPurchase 전 purchase"+purchase);
		purchaseService.addPurchase(purchase);
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("prodNo", purchase.getPurchaseProd().getProdNo());
		map.put("tranCode", "1");
		productService.updateProductTranCode(map);
	}
	
	//@RequestMapping(value="addPurchase", method=RequestMethod.GET)
	public String addPurchaseView(@RequestParam("prodNo")String prodNo,
									@ModelAttribute("purchase")Purchase purchase,
									HttpSession session,
									Model model) throws Exception{
		
		purchase.setPurchaseProd(productService.getProduct(Integer.parseInt(prodNo)));
		System.out.println(purchase.getPurchaseProd());
		purchase.setBuyer((User)session.getAttribute("user"));
		System.out.println(purchase.getBuyer());
		
		model.addAttribute("purchase", purchase);
				
		return "forward:/purchase/addPurchaseView.jsp";
	}
	
	@RequestMapping(value="/json/getPurchase/{tranNo}")
	public Purchase getPurchase(@PathVariable("tranNo") String tranNo) throws NumberFormatException, Exception{
		
		Purchase purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		purchase.setPaymentOption(purchase.getPaymentOption().trim());
		System.out.println("겟펄쳐스액션"+purchase);
		
		return purchase;
	}
	
	//@RequestMapping(value="updatePurchaseView", method=RequestMethod.GET)
	public String updatePurchase(@ModelAttribute("purchase")Purchase purchase,
										@RequestParam("tranNo")String tranNo,
										Model model) throws Exception{
		purchase = purchaseService.getPurchase(Integer.parseInt(tranNo));
		
		model.addAttribute("purchase", purchase);
		
		return "forward:/purchase/updatePurchaseView.jsp";
	}
	
	@RequestMapping(value="/json/updatePurchase", method=RequestMethod.POST)
	public String updatePurchase(@RequestParam("jsonString") String jsonPurchase,
									@RequestParam("file") MultipartFile fileName) throws Exception{
		
		ObjectMapper objectMapper = new ObjectMapper();
		Purchase purchase = (Purchase)objectMapper.readValue(jsonPurchase, Purchase.class);
		purchase.setTranNo(10221);
		purchase.setDlvyRequest("업데이트");
		
		purchaseService.updatePurchase(purchase);
		
		return "forward:/purchase/getPurchase";
	}
	
	@RequestMapping(value="/json/listPurchase")
	public Map<String,Object> listPurchase(@ModelAttribute("search")Search search) throws Exception{
//		String userId = null;
		
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		
		System.out.println("현재 커런트 페이지"+search.getCurrentPage());

		search.setPageUnit(pageUnit);

//		try{
//		userId = ((User)(session.getAttribute("user"))).getUserId();
//		}catch(NullPointerException e){
//			throw new Exception("로그인 풀린 상태.");
//		}

		//임시로 자료 대입
		String userId = "user02";
		
		Map<String, Object> map = purchaseService.getPurchaseList(search, userId);
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
						pageUnit, pageSize);
		System.out.println("ListPurchaseAction ::"+resultPage);
		
		List<Purchase> list = (List<Purchase>)map.get("list");
		for (int i = 0; i < list.size(); i++) {
			list.get(i).setTranCode(list.get(i).getTranCode().trim());
			list.get(i).setPurchaseProd(productService.getProduct(list.get(i).getPurchaseProd().getProdNo()));
		}
		
		
		/*model.addAttribute("resultPage", resultPage);
		model.addAttribute("list", map.get("list"));
		model.addAttribute("search",search);*/
		
		Map<String,Object> bigMap = new HashMap<String, Object>();
		
		bigMap.put("resultPage", resultPage);
		bigMap.put("list", list);
		bigMap.put("search", search);
		
		return bigMap;
	}
	
	@RequestMapping(value="/json/listSale")
	public Map<String,Object> listSale(@ModelAttribute("search")Search search,
							 Model model) throws Exception{
		
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = purchaseService.getSaleList(search);
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
						pageUnit, pageSize);
		
		Map<String,Object> bigMap = new HashMap<String,Object>();
		
		bigMap.put("resultPage", resultPage);
		bigMap.put("list", map.get("list"));
		bigMap.put("search", search);
		
		return bigMap;
	}
	
	@RequestMapping(value="/json/updateTranCode", method=RequestMethod.GET)
	public String updateTranCode(@RequestParam("tranNo")String tranNo,
									@RequestParam("tranCode")String tranCode) throws NumberFormatException, Exception{
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("tranNo", Integer.parseInt(tranNo));
		map.put("tranCode", Integer.parseInt(tranCode));
		purchaseService.updateTranCode(map);
		map.put("prodNo", productService.getProductNo(Integer.parseInt(tranNo)));
		productService.updateProductTranCode(map);
		
		return "forward:/purchase/listPurchase";
	}
	
	@RequestMapping(value="/json/updateTranCodeByProd",method=RequestMethod.GET)
	public String updateTranCodeByProd(@RequestParam("prodNo")String prodNo,
											@RequestParam("tranCode")String tranCode) throws Exception{
		Map<String, Object>map = new HashMap<String, Object>();
		map.put("prodNo", Integer.parseInt(prodNo));
		map.put("tranCode", Integer.parseInt(tranCode));
		purchaseService.updateTranCode(map);
		productService.updateProductTranCode(map);
				
		return "forward:/product/listProduct?menu=manage";
	}
	
	@RequestMapping(value="/json/cancelPurchase/{tranNo}", method=RequestMethod.GET)
	public String cancelPurchase(@PathVariable("tranNo")String tranNo) throws Exception{
		Map<String, Object>map = new HashMap<String, Object>();
		System.out.println("캔슬펄쳐스 트랜노"+tranNo);
		map.put("prodNo", productService.getProductNo(Integer.parseInt(tranNo)));
		map.put("tranCode", null);
		productService.updateProductTranCode(map);
		purchaseService.deletePurchase(tranNo);
		
		return "forward:/purchase/listPurchase";
	}
	
	@RequestMapping(value="/json/addWishPurchase/{prodNo}/{userId}", method=RequestMethod.GET)
	public void addWishPurchase(@ModelAttribute("wish")Wish wish,
									  @ModelAttribute("purchase")Purchase purchase,
									  @PathVariable("prodNo")String prodNo,
									  @PathVariable("userId")String userId) throws Exception{

		
		Product product = new Product();
		product.setProdNo(Integer.parseInt(prodNo));
		
		User user = new User();
		user.setUserId(userId);
		
		purchase.setPurchaseProd(product);
		purchase.setBuyer(user); 
		
		purchaseService.addWishPurchase(purchase);
		
	}
	
	@RequestMapping(value="/json/listWishPurchase/{userId}")
	public Map<String,Object> listWishPurchase(@ModelAttribute("search")Search search,
										@PathVariable("userId")String userId) throws Exception{
		
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
		
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = purchaseService.getWishList(search, userId);
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
						pageUnit, pageSize);
		
		List<Wish> list = (List<Wish>)map.get("list");
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getTranStatusCode() != null){
				list.get(i).setTranStatusCode(list.get(i).getTranStatusCode().trim());
			}
			list.get(i).setPurchaseProd(productService.getProduct(list.get(i).getPurchaseProd().getProdNo()));
		}
		
		Map<String, Object> bigMap = new HashMap<String,Object>();
		
		bigMap.put("resultPage", resultPage);
		bigMap.put("list", list);
		bigMap.put("search", search);
		
		return bigMap;
	}
	
	@RequestMapping(value="/json/cancelWishPurchase/{wishNo}", method=RequestMethod.GET)
	public void cancelWishPurchase(@PathVariable("wishNo")String wishNo) throws Exception{
		purchaseService.deleteWishPurchase(wishNo);
		
	}
	
}
