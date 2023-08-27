package com.poly.controller;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.http.MediaType;

import com.itextpdf.text.Document;
import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfWriter;
import com.poly.bean.Account;
import com.poly.bean.Book;
import com.poly.service.AccountService;
import com.poly.service.BookService;

@RestController
public class PdfController {
	@Autowired
	AccountService accountService;
	
	@Autowired
	BookService bookService;
	
	@GetMapping("/print-to-pdf")
    public ResponseEntity<byte[]> printToPdf() throws IOException, DocumentException {
        List<Account> dataList = getAll(); // Hàm này tạo dữ liệu mẫu

        Document document = new Document() {
		};
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, outputStream);

        document.open();
        for (Account data : dataList) {
            document.add(new Paragraph("Photo: " + data.getPhoto()));
            document.add(new Paragraph("Username: " + data.getUsername()));
            document.add(new Paragraph("Fullname: " + data.getFullname()));
            document.add(new Paragraph("Email: " + data.getEmail()));
            // Thêm các đoạn văn bản khác tùy ý
            document.add(new Paragraph("----------------------------"));
        }
        document.close();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "exportPDF.pdf");

        return ResponseEntity.ok()
            .headers(headers)
            .body(outputStream.toByteArray());
    }

    public final List<Account> getAll() {
		return accountService.findAll();
	}
    
	@GetMapping("/print-to-pdfsp")
    public ResponseEntity<byte[]> printToPdfSP() throws IOException, DocumentException {
        List<Book> dataList = getAllsp(); // Hàm này tạo dữ liệu mẫu

        Document document = new Document() {
		};
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, outputStream);

        document.open();
        for (Book data : dataList) {
            document.add(new Paragraph("Id: " + data.getId()));
            document.add(new Paragraph("Name: " + data.getName()));
            document.add(new Paragraph("Price: " + data.getPrice()));
            document.add(new Paragraph("Date: " + data.getPublication_date()));
            document.add(new Paragraph("Image: " + data.getImage()));
            document.add(new Paragraph("Email: " + data.getAuthor()));
            document.add(new Paragraph("Available: " + data.getAvailable()));
            // Thêm các đoạn văn bản khác tùy ý
            document.add(new Paragraph("----------------------------"));
        }
        document.close();

        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", "exportPDF.pdf");

        return ResponseEntity.ok()
            .headers(headers)
            .body(outputStream.toByteArray());
    }

    public final List<Book> getAllsp() {
		return bookService.findAll();
	}

}
