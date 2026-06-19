package com.certifyhub.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RestController;

import com.certifyhub.dto.CertificateDto;
import com.certifyhub.service.CertificateService;

@RestController
public class CertificateController {

	private final CertificateService examService;

	public CertificateController(CertificateService examService) {
		this.examService = examService;
	}

	@GetMapping("/api/certificate/{userId}/{courseId}")
	public CertificateDto getCertificate(@PathVariable Integer userId, @PathVariable Integer courseId) {

		return examService.getCertificate(userId, courseId);
	}
}
