package com.certifyhub.controller;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import com.certifyhub.dto.ExamRequest;
import com.certifyhub.service.ExamService;

@RestController
public class ExamController {

	private final ExamService examService;

	public ExamController(ExamService examService) {
		this.examService = examService;
	}

	@PostMapping("/api/exam")
	public String submitExam(@RequestBody ExamRequest request) {
		return examService.submitExam(request);
	}
}
