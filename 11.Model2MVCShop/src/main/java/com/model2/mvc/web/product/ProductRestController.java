package com.model2.mvc.web.product;

import java.io.File;
import java.net.URLDecoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.model2.mvc.common.Page;
import com.model2.mvc.common.Search;
import com.model2.mvc.common.util.CommonUtil;
import com.model2.mvc.service.domain.Comment;
import com.model2.mvc.service.domain.Product;
import com.model2.mvc.service.domain.User;
import com.model2.mvc.service.product.ProductService;

@RestController
@RequestMapping("/product/*")
public class ProductRestController {

	@Autowired
	@Qualifier("productServiceImpl")
	private ProductService productService;
	
	@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	public ProductRestController() {
		System.out.println("productController() default Constructor ");
	}

	@RequestMapping(value="/json/addProduct", method=RequestMethod.POST)
	public void addProduct(@RequestParam("file") MultipartFile fileName,
										@RequestParam("product") String jsonString,
										HttpSession session)throws Exception{
		System.out.println("프로덕트 제이슨스트링"+jsonString);
		ObjectMapper objectMapper = new ObjectMapper();
		
		Product product = objectMapper.readValue(jsonString, Product.class);
		System.out.println("옵젝매퍼로 만든 프로덕트"+product);
		
		String uploadFiles = session.getServletContext().getRealPath("/images/uploadFiles");
		System.out.println("session of getRealPath : "+session.getServletContext().getRealPath("/images/uploadFiles"));
		String originalFilename = fileName.getOriginalFilename();
		System.out.println("file of OriginalFileName : "+fileName.getOriginalFilename());
		String fullPath = uploadFiles + "\\" + originalFilename;
		System.out.println("fullPath"+fullPath);
		if (!fileName.isEmpty()) {
			try {
				product.setFileName(fileName.getOriginalFilename());
				File file = new File(fullPath);
				fileName.transferTo(file);

//				OutputStream os = new FileOutputStream(file);
//				os.write(fileName.getBytes());
//				os.flush();
//				os.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("파일이 비어있습니다.");
		}
		

		product.setManuDate(CommonUtil.toStrDateStr("2017-08-09"));
		productService.addProduct(product);

	}
	
	@RequestMapping(value="/json/getProduct/{prodNo}")
	public Product getProduct(@PathVariable("prodNo") String prodNo,
									  @RequestParam(value="menu",defaultValue="") String menu,
									  HttpServletRequest request, 
									  HttpServletResponse response,
									  HttpSession session,
									  @CookieValue(value="history",required=false) String history,
									  @RequestParam(value="userComment", required=false)String userComment)
									  throws Exception{
		
		//쿠키 관리를 위한 부분
//		System.out.println("Cookie History : "+history);
//		Cookie cookie=null;
//		if(history == null){
//			cookie = new Cookie("history",prodNo);
//			System.out.println("히스토리가 널일때 첫생성");
//		}else{
//			cookie = new Cookie("history",history+","+prodNo);
//			System.out.println("히스토리가 널이 아닐때 전쿠키에 추가");
//		}
//		cookie.setMaxAge(60*3);
//		cookie.setPath("/");
//		response.addCookie(cookie);
		
		
		//댓글을 위한 부분
//		if(userComment != null){
//			Map<String, Object> map = new HashMap<String, Object>();
//			User user = (User)(session.getAttribute("user"));
//			map.put("userId", user.getUserId());
//			map.put("comments", userComment);
//			map.put("prodNo", prodNo);
//			productService.addProductComment(map);
//		}
//		List<Comment> list = productService.getProductComment(prodNo);
//		
		Product product= productService.getProduct(Integer.parseInt(prodNo));
		if(product.getTranStatusCode() != null){
			product.setTranStatusCode(product.getTranStatusCode().trim());	
		}
		
				
//		ModelAndView modelAndView = new ModelAndView();
		
//		modelAndView.addObject("list",list);
//		modelAndView.addObject("product",product);
		
		
		if(menu!=""){
			if(menu.equals("manage")){
				return product;
			}
		}
		return product;
	}
	
	//@RequestMapping(value = "updateProduct", method=RequestMethod.GET)
	public ModelAndView updateProductView(@RequestParam("prodNo")String prodNo) throws NumberFormatException, Exception{
		
		Product product = productService.getProduct(Integer.parseInt(prodNo));

		ModelAndView modelAndView = new ModelAndView();
		modelAndView.addObject("product",product);
		modelAndView.setViewName("forward:/product/updateProductView.jsp");
		
		return modelAndView;
	}
	
	@RequestMapping(value = "/json/updateProduct", method=RequestMethod.POST)
	public void updateProduct(@RequestParam("file")MultipartFile fileName,
									@RequestParam("jsonString")String jsonString,
									HttpSession session) throws Exception{
		
		ObjectMapper objectMapper = new ObjectMapper();
		Product product = (Product)objectMapper.readValue(jsonString, Product.class);
		
		String uploadFiles = session.getServletContext().getRealPath("/images/uploadFiles");
		System.out.println("session of getRealPath : "+session.getServletContext().getRealPath("/images/uploadFiles"));
		String originalFilename = fileName.getOriginalFilename();
		System.out.println("file of OriginalFileName : "+fileName.getOriginalFilename());
		String fullPath = uploadFiles + "\\" + originalFilename;
		System.out.println("fullPath"+fullPath);
		if (!fileName.isEmpty()) {
			try {
				product.setFileName(fileName.getOriginalFilename());
				File file = new File(fullPath);
				fileName.transferTo(file);

//				OutputStream os = new FileOutputStream(file);
//				os.write(fileName.getBytes());
//				os.flush();
//				os.close();

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			System.out.println("파일이 비어있습니다.");
		}
		
		productService.updateProduct(product);

	}
	
	@RequestMapping(value="/json/listProduct")
	public Map<String,Object> listProduct(@ModelAttribute("search")Search search,
											@RequestBody String jsonString) throws Exception{
		JSONObject jo = (JSONObject)JSONValue.parse(jsonString);
		System.out.println((Long)(jo.get("currentPage")));
		search.setCurrentPage(Math.toIntExact((Long)jo.get("currentPage")));
		System.out.println(search.getCurrentPage()+"여기 커런트페이지인데?");
		
		if(search.getCurrentPage()==0){
			search.setCurrentPage(1);
		}
			System.out.println("이번에 눌린 페이지"+search.getCurrentPage());
		
		if(search.getSearchSortPrice()=="" ||search.getSearchSortPrice()==null){
			search.setSearchSortPrice("0");
		}
			System.out.println("이번에 가격 정렬기준"+search.getSearchSortPrice());

		System.out.println("리프액 searchCondition"+search.getSearchCondition());
		System.out.println("리프액 searchKeyword"+search.getSearchKeyword());
			
		search.setPageUnit(pageUnit);
		
		Map<String, Object> map = productService.getProductList(search);
		
		
		Page resultPage	= 
				new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(),
						pageUnit, pageSize);
		System.out.println("ListProductAction ::"+resultPage);
	
		List<Product> list = (List<Product>)map.get("list");
		for (int i = 0; i < list.size(); i++) {
			if(list.get(i).getTranStatusCode() != null){
				list.get(i).setTranStatusCode(list.get(i).getTranStatusCode().trim());
			}
		}
		
		System.out.println("ProductControll List 확인용 : "+map.get("list").toString());
		
		map.put("resultPage",resultPage);
		map.put("search", search);
		
		return map;
	}
	
	
	@RequestMapping(value="/json/autoListProduct", method=RequestMethod.POST)
		public List<String> autoListProduct(@RequestBody String jsonString) throws Exception{

		JSONObject jsonObject = (JSONObject)JSONValue.parse(jsonString);

		String name = URLDecoder.decode(((String)jsonObject.get("name")), "UTF-8");
		
		List<String> list = productService.getAutoProductList(name);	
		
		return list;
	}
	
	//@RequestMapping(value="commentDelete", method=RequestMethod.GET)
	public ModelAndView commentDelete(@RequestParam("productCommentNo")String productCommentNo) throws Exception{
		
		productService.deleteProductComment(productCommentNo);
		
		ModelAndView modelAndView = new ModelAndView();
		modelAndView.setViewName("forward:/product/getProduct");
		return modelAndView;
	}
	
}
