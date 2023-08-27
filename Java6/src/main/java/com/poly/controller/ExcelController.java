package com.poly.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import com.poly.bean.Account;
import com.poly.bean.Book;
import com.poly.service.AccountService;
import com.poly.service.BookService;

@RestController
public class ExcelController {
	@Autowired
	AccountService accountService;

	@Autowired
	BookService bookService;
	
	@GetMapping("/print-to-excel")
	public ResponseEntity<byte[]> printToExcel() throws IOException {
		List<Account> dataList = getAll(); // Hàm này tạo dữ liệu mẫu

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Data");

		int rowIdx = 0;
		for (Account data : dataList) {
			Row row = sheet.createRow(rowIdx++);
			row.createCell(0).setCellValue(data.getPhoto());
			row.createCell(1).setCellValue(data.getUsername());
			row.createCell(3).setCellValue(data.getFullname());
			row.createCell(4).setCellValue(data.getEmail());
			// Thêm cột khác tùy ý
		}

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		workbook.write(outputStream);
		workbook.close();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", "data.xlsx");

		return ResponseEntity.ok().headers(headers).body(outputStream.toByteArray());
	}

	public final List<Account> getAll() {
		return accountService.findAll();
	}
	
	@GetMapping("/print-to-excelsp")
	public ResponseEntity<byte[]> printToExcelsp() throws IOException {
		List<Book> dataList = getAllsp(); // Hàm này tạo dữ liệu mẫu

		Workbook workbook = new XSSFWorkbook();
		Sheet sheet = workbook.createSheet("Data");

		int rowIdx = 0;
		for (Book data : dataList) {
			Row row = sheet.createRow(rowIdx++);
			row.createCell(0).setCellValue(data.getId());
			row.createCell(1).setCellValue(data.getName());
			row.createCell(2).setCellValue(data.getPrice());
			row.createCell(3).setCellValue(data.getPublication_date());
			row.createCell(4).setCellValue(data.getImage());
			row.createCell(5).setCellValue(data.getAuthor());
			row.createCell(6).setCellValue(data.getAvailable());
			
			// Thêm cột khác tùy ý
		}

		ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
		workbook.write(outputStream);
		workbook.close();

		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
		headers.setContentDispositionFormData("attachment", "data.xlsx");

		return ResponseEntity.ok().headers(headers).body(outputStream.toByteArray());
	}

	 public final List<Book> getAllsp() {
			return bookService.findAll();
		}
}
