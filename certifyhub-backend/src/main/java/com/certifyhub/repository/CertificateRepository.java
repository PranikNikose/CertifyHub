package com.certifyhub.repository;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class CertificateRepository {

	private final JdbcTemplate jdbcTemplate;

	public CertificateRepository(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public Map<String, Object> getCertificate(Integer userId, Integer courseId) {

		String sql = """
				SELECT
				    u.full_name,
				    cm.course_name,
				    ucr.percentage,
				    ucr.exam_status,
				    to_char(ucr.issue_date,'DD-Mon-YYYY') as issue_date
				FROM users u
				JOIN user_course_result ucr
				    ON u.user_id = ucr.user_id
				JOIN course_master cm
				    ON cm.course_id = ucr.course_id
				WHERE u.user_id = ?
				AND cm.course_id = ?
				AND ucr.exam_status = 'PASS'
				""";

		List<Map<String, Object>> result = jdbcTemplate.queryForList(sql, userId, courseId);

		return result.isEmpty() ? null : result.get(0);
	}
}