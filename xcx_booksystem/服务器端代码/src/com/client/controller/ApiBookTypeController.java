package com.client.controller;

import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.chengxusheji.po.BookType;
import com.chengxusheji.service.BookTypeService;
import com.client.utils.JsonResult;
import com.client.utils.JsonResultBuilder;

@RestController
@RequestMapping("/api/bookType") 
public class ApiBookTypeController {
	
	@Resource BookTypeService bookTypeService;
	
	@RequestMapping(value="/listAll",method=RequestMethod.POST)
	public JsonResult list(String barcode,String bookName,@ModelAttribute("bookTypeObj") BookType bookTypeObj,String publishDate,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception{
		List<BookType> bookTypeList = bookTypeService.queryAllBookType(); 
		return JsonResultBuilder.ok(bookTypeList);
	}
}
