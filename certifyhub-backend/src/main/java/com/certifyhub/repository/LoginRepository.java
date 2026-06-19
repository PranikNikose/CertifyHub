package com.certifyhub.repository;

import java.util.List;
import java.util.Map;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class LoginRepository {

	private final JdbcTemplate jdbcTemplate;

	public LoginRepository(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}

	public Map<String, Object> validateUser(String username, String password) {

		String sql = """
				SELECT user_id, username, full_name FROM users WHERE username = ? AND password = ?
				""";

		List<Map<String, Object>> result = jdbcTemplate.queryForList(sql, username, password);

		return result.isEmpty() ? null : result.get(0);
	}
}