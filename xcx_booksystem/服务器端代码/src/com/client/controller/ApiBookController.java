package com.client.controller;

import java.util.HashMap;
import java.util.List;
import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import com.chengxusheji.po.Book;
import com.chengxusheji.po.BookType;
import com.chengxusheji.service.BookService; 
import com.client.utils.JsonResult;
import com.client.utils.JsonResultBuilder;
import com.client.utils.ReturnCode;

@RestController
@RequestMapping("/api/book") 
public class ApiBookController {
	@Resource BookService bookService; 
	
	@InitBinder("bookTypeObj")
	public void initBinderbookTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("bookTypeObj.");
	}
	
	@InitBinder("book")
	public void initBinderBook(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("book.");
	}
	
	
	/*客户端ajax方式添加图书信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public JsonResult add(@Validated Book book, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (br.hasErrors()) //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR);	 
		if(bookService.getBook(book.getBarcode()) != null) //验证主键是否重复
			return JsonResultBuilder.error(ReturnCode.PRIMARY_EXIST_ERROR);
        bookService.addBook(book); //添加到数据库
        return JsonResultBuilder.ok();
	}
	
	
	/*客户端ajax更新图书信息*/
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public JsonResult update(@Validated Book book, BindingResult br, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (br.hasErrors())  //验证输入参数
			return JsonResultBuilder.error(ReturnCode.INPUT_PARAM_ERROR);  
        bookService.updateBook(book);  //更新记录到数据库
        return JsonResultBuilder.ok(bookService.getBook(book.getBarcode()));
         
	}
	 
	
	/*ajax方式显示获取图书详细信息*/
	@RequestMapping(value="/get/{barcode}",method=RequestMethod.POST)
	public JsonResult getBook(@PathVariable String barcode,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键barcode获取Book对象*/
        Book book = bookService.getBook(barcode); 
        return JsonResultBuilder.ok(book);
	}
	
	
	/*ajax方式删除图书记录*/
	@RequestMapping(value="/delete/{barcode}",method=RequestMethod.POST)
	public JsonResult deleteBook(@PathVariable String barcode,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
		bookService.deleteBook(barcode);
        return JsonResultBuilder.ok();
	}
	
	//客户端查询图书信息
	@RequestMapping(value="/list",method=RequestMethod.POST)
	public JsonResult list(String barcode,String bookName,@ModelAttribute("bookTypeObj") BookType bookTypeObj,String publishDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception{
		if (page==null || page == 0) page = 1;
		if (barcode == null) barcode = "";
		if (bookName == null) bookName = "";
		if (publishDate == null) publishDate = ""; 
		if(rows != 0)bookService.setRows(rows);
		List<Book> bookList = bookService.queryBook(barcode, bookName, bookTypeObj, publishDate, page);
	    /*计算总的页数和总的记录数*/
	    bookService.queryTotalPageAndRecordNumber(barcode, bookName, bookTypeObj, publishDate);
	    /*获取到总的页码数目*/
	    int totalPage = bookService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = bookService.getRecordNumber();
	    
	    HashMap<String, Object> resultMap = new HashMap<String, Object>();
	    resultMap.put("totalPage", totalPage);
	    resultMap.put("list", bookList);
	    
		return JsonResultBuilder.ok(resultMap);
	}
	
	
	
	//客户端查询5本最新出版的图书记录*/
	@RequestMapping(value="/latest_list",method=RequestMethod.POST)
	public JsonResult latestList(String barcode,String bookName,@ModelAttribute("bookTypeObj") BookType bookTypeObj,String publishDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception{
		
		List<Book> bookList = bookService.queryLatestBook(); 
	    HashMap<String, Object> resultMap = new HashMap<String, Object>(); 
	    resultMap.put("list", bookList);
	    
		return JsonResultBuilder.ok(resultMap);
	}
}
