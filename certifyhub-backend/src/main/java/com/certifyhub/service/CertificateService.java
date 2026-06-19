package com.certifyhub.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.certifyhub.dto.CertificateDto;
import com.certifyhub.repository.CertificateRepository;

@Service
public class CertificateService {

	private final CertificateRepository certificateRepository;

	public CertificateService(CertificateRepository certificateRepository) {
		this.certificateRepository = certificateRepository;
	}

	public CertificateDto getCertificate(Integer userId, Integer courseId) {

		Map<String, Object> row = certificateRepository.getCertificate(userId, courseId);

		if (row == null) {
			return null;
		}

		CertificateDto dto = new CertificateDto();

		dto.setCandidateName((String) row.get("full_name"));

		dto.setCourseName((String) row.get("course_name"));

		dto.setPercentage((Integer) row.get("percentage"));

		dto.setExamStatus((String) row.get("exam_status"));

		dto.setIssueDate(String.valueOf(row.get("issue_date")));

		return dto;
	}
}