package com.certifyhub.service;

import org.springframework.stereotype.Service;

import com.certifyhub.dto.ExamRequest;
import com.certifyhub.repository.ExamRepository;

@Service
public class ExamService {

	private final ExamRepository examRepository;

	public ExamService(ExamRepository examRepository) {
		this.examRepository = examRepository;
	}

	public String submitExam(ExamRequest request) {

		examRepository.saveExamResult(request.getUserId(), request.getCourseId(), request.getPercentage(),
				request.getExamStatus());

		return "Exam Result Saved Successfully";
	}
}
