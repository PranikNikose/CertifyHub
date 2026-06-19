package com.certifyhub.service;

import java.util.Map;

import org.springframework.stereotype.Service;

import com.certifyhub.dto.LoginRequest;
import com.certifyhub.dto.LoginResponse;
import com.certifyhub.repository.LoginRepository;

@Service
public class LoginService {

	private final LoginRepository loginRepository;

	public LoginService(LoginRepository loginRepository) {
		this.loginRepository = loginRepository;
	}

	public LoginResponse login(LoginRequest request) {

		LoginResponse response = new LoginResponse();

		Map<String, Object> user = loginRepository.validateUser(request.getUsername(), request.getPassword());

		if (user != null) {

			response.setSuccess(true);
			response.setUserId((Integer) user.get("user_id"));
			response.setUsername((String) user.get("username"));
			response.setFullName((String) user.get("full_name"));
			response.setMessage("Login Successful");

		} else {

			response.setSuccess(false);
			response.setMessage("Invalid Username Or Password");
		}

		return response;
	}
}