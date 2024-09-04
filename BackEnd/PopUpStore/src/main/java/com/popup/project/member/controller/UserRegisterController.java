package com.popup.project.member.controller;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.popup.project.member.auth.CustomUserDetails;
import com.popup.project.member.dto.UserDTO;
import com.popup.project.member.mail.MailService;
import com.popup.project.member.mapper.UserMapper;
import com.popup.project.member.service.UserService;

import jakarta.mail.MessagingException;
import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;

@Controller
public class UserRegisterController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private UserMapper userMapper;
	
	@Autowired
	private BCryptPasswordEncoder pwEncoder;
	
	@Autowired
	private MailService mailService;
	
	// 회원가입페이지
	@GetMapping("register_form")
	public String register() {
		return "Guest/auth/Signup";
	}
	
	// 아이디 / 비밀번호 찾기
	@GetMapping("/FindIdPw")
	public String FindIdPw() {
		return "Guest/auth/FindIdPw";
	}
	
	// 비밀번호 찾기 검증 
	@PostMapping("/FindPwAuth")
	public String FindPwAuth() {
	    return "/Guest/auth/FindPwAuth";
	}
	
	// 아이디 찾기
	@GetMapping("/FindId")
	@ResponseBody
	public Map<String, String> FindId(@RequestParam("name") String name, @RequestParam("phone") String phone) {
	    Map<String, String> response = new HashMap<>();
	    try {
	        String userId = userService.FindId(name, phone);
	        System.out.println("userId: " + userId);  // 로그로 결과 확인
	        if (userId != null) {
	            response.put("status", "success");
	            response.put("userId", userId);
	        } else {
	            response.put("status", "not found");
	        }
	    } catch (Exception e) {
	        response.put("status", "error");
	        response.put("message", e.getMessage());
	    }
	    return response;
	}
	
	// 아이디 중복확인 
	@PostMapping("/CheckUserId")
	@ResponseBody
	public Map<String, String> checkUserId(@RequestParam("userId") String userId) {
	    Map<String, String> response = new HashMap<>();
	    int count = userService.IdCheck(userId);
	    System.out.println("Received userId: " + userId + ", Count: " + count); // 로그 추가
	    if (count > 0) {
	        response.put("status", "exists");
	    } else {
	        response.put("status", "not found");
	    }
	    return response;
	}
	
	
	// 비밀번호 찾기시 이름과 이메일 일치할경우 인증번호 발송
	@RequestMapping(value = "/CheckNameEmail", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public ResponseEntity<Map<String, String>> checkUserNameAndEmail(@RequestParam("userName") String userName, @RequestParam("userEmail") String userEmail) {
	    Map<String, String> response = new HashMap<>();
	    try {
	        boolean isMatched = userService.checkUserNameAndEmail(userName, userEmail);
	        if (isMatched) {
	            response.put("status", "matched");
	        } else {
	            response.put("status", "not_matched");
	        }
	        return ResponseEntity.ok(response);
	    } catch (Exception e) {
	        // 로그를 남기고, 일반적인 오류 상태를 반환
	        e.printStackTrace();
	        response.put("status", "error");
	        response.put("message", "An unexpected error occurred. Please try again later.");
	        return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(response);
	    }
	}
	
	// 아이디 중복체크
	@RequestMapping(value = "IdCheck", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<Object, Object> IdCheck(@RequestBody String id) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = userService.IdCheck(id);
		map.put("cnt", count);
		return map;
	}
	
	// 닉네임 중복체크
	@RequestMapping(value = "NickCheck", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<Object, Object> NickCheck(@RequestBody String nick) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = userService.NickCheck(nick);
		map.put("cnt", count);
		return map;
	}
	
	// 이메일 중복체크
	@RequestMapping(value = "EmailCheck", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<Object, Object> EmailCheck(@RequestBody String email) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = userService.EmailCheck(email);
		map.put("cnt", count);
		return map;
	}
	
	// 전화번호 중복체크
	@RequestMapping(value = "PhoneCheck", method = RequestMethod.POST, produces = "application/json; charset=utf8")
	@ResponseBody
	public Map<Object, Object> PhoneCheck(@RequestBody String phone) {
		int count = 0;
		Map<Object, Object> map = new HashMap<Object, Object>();
		count = userService.PhoneCheck(phone);
		map.put("cnt", count);
		return map;
	}
	
	// 회원가입 컨트롤러
	@PostMapping("register")
	public String register(@Valid UserDTO dto, BindingResult bindingResult, Model model) {

	    // 비밀번호 일치 여부 확인
	    if (!dto.getUserPwd().equals(dto.getUserPwdConfirm())) {
	        bindingResult.rejectValue("userPwdConfirm", "error.userPwdConfirm", "비밀번호가 일치하지 않습니다.");
	    }

	    // 유효성 검증 에러가 있는 경우
	    if (bindingResult.hasErrors()) {
	        // 모든 에러 메시지 로그 출력 (디버깅용)
	        bindingResult.getAllErrors().forEach(error -> System.out.println(error.toString()));
	        
	        model.addAttribute("errMessages", bindingResult.getAllErrors());
	        return "Guest/auth/Signup";
	    }

	    // 전화번호 중복 확인 (클라이언트에서 결합한 값이 dto.getUserPhone()에 들어가야 합니다)
	    int PhoneCheckResult = userService.PhoneCheck(dto.getUserPhone());
	    
	    // ID, 닉네임, 이메일 중복 확인
	    int idCheckResult = userService.IdCheck(dto.getUserId());
	    int nickCheckResult = userService.NickCheck(dto.getUserNick());
	    int emailCheckResult = userService.EmailCheck(dto.getUserEmail());
	    
	    // 중복된 경우 에러 메시지 반환
	    if (idCheckResult > 0) {
	        model.addAttribute("errorMessage", "이미 사용 중인 아이디입니다.");
	        return "Guest/auth/Signup";
	    } else if (nickCheckResult > 0) {
	        model.addAttribute("errorMessage", "이미 사용 중인 닉네임입니다.");
	        return "Guest/auth/Signup";
	    } else if (emailCheckResult > 0) {
	        model.addAttribute("errorMessage", "이미 사용 중인 이메일입니다.");
	        return "Guest/auth/Signup";
	    } else if (PhoneCheckResult > 0) {
	        model.addAttribute("errorMessage", "이미 사용 중인 전화번호입니다.");
	        return "Guest/auth/Signup";
	    } else {
	        // 모든 검증을 통과한 경우 회원가입 처리
	        userService.register(dto);
	        return "redirect:/Guest/auth/Login?success=true";
	    }
	}
	
	// 1. 소셜 로그인 성공 후 처리
    @GetMapping("/SocialForm")
    public String showSocialForm(HttpSession session, Model model) {
        UserDTO socialUser = (UserDTO) session.getAttribute("socialUser");
        System.out.println("SocialUser in session: " + socialUser);

        if (socialUser == null) {
            System.out.println("Social user is null. Redirecting to home.");
            return "redirect:/";
        }

        // 사용자가 소셜 로그인 중 구글 또는 네이버인지 확인
        if ((socialUser.getSocialProvider().equals("google") && socialUser.getUserNick() != null && !socialUser.getUserNick().startsWith("google_")) ||
                (socialUser.getSocialProvider().equals("naver") && socialUser.getUserNick() != null && !socialUser.getUserNick().startsWith("naver_")) ||
                (socialUser.getSocialProvider().equals("kakao") && socialUser.getUserNick() != null && !socialUser.getUserNick().startsWith("kakao_"))) {
                System.out.println("User nickname is already set and not a default value. Redirecting to home.");
                return "redirect:/";
        }

        System.out.println("Navigating to SocialForm.");
        model.addAttribute("socialUser", socialUser);
        return "Guest/auth/SocialForm"; // 이동할 JSP 파일 경로
    }

    @PostMapping("/SocialForm")
    public String processSocialForm(UserDTO userDTO, HttpSession session) {
        UserDTO socialUser = (UserDTO) session.getAttribute("socialUser");
        if (socialUser != null) {
            // 닉네임 및 기타 정보 검증
            if (userMapper.NickCheck(userDTO.getUserNick()) > 0) {
                return "redirect:/SocialForm?error=nick";
            }

            socialUser.setUserNick(userDTO.getUserNick());
            socialUser.setUserName(userDTO.getUserName());
            socialUser.setUserPhone(userDTO.getUserPhone());
            socialUser.setUserZipcode(userDTO.getUserZipcode());
            socialUser.setUserAddress(userDTO.getUserAddress());

            // DB에 정보 저장
            userMapper.updateUserBySocialIdAndProvider(socialUser);

            // 사용자 인증 후 메인 페이지로 리다이렉트
            CustomUserDetails userDetails = new CustomUserDetails(socialUser);
            UsernamePasswordAuthenticationToken auth = new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());
            SecurityContextHolder.getContext().setAuthentication(auth);
            
            return "redirect:/?signupSuccess=true";  // 성공 메시지를 URL 파라미터로 전달
        }

        return "redirect:/";
    }
	
    // 추가 인증 페이지 보여주기 (GET)
    @GetMapping("/Member/auth/AccountAuth")
    public String showAccountAuthPage(Model model) {
        model.addAttribute("message", "계정이 잠겼습니다. 이메일로 받은 인증 코드를 입력하세요.");
        return "/Member/auth/AccountAuth"; // 인증 페이지로 이동
    }
    
    @PostMapping("/AuthCode")
    public ResponseEntity<Map<String, Boolean>> verifyAuthCode(@RequestBody Map<String, String> request, HttpSession session) throws MessagingException {
        System.out.println("verifyAuthCode method start.");

        String authCode = request.get("authCode");
        System.out.println("Auth Code received: " + authCode);

        String savedAuthCode = (String) session.getAttribute("authNumber");
        String email = (String) session.getAttribute("email");
        System.out.println("Saved Auth Code: " + savedAuthCode);
        System.out.println("Email in session: " + email);

        if (email == null || email.isEmpty()) {
            throw new IllegalArgumentException("유효한 이메일 주소가 필요합니다.");
        }

        Map<String, Boolean> response = new HashMap<>();

        if (savedAuthCode != null && savedAuthCode.trim().equals(authCode)) {
            response.put("verified", true);
            session.removeAttribute("authNumber");
            System.out.println("Auth code verified, sending temp password.");
            
            // 임시 비밀번호 발송
            try {
                System.out.println("Calling sendTempPasswordAsync for email: " + email);
                mailService.sendTempPasswordAsync(email, session, userService);
                System.out.println("Async call made for sending temp password.");
            } catch (Exception e) {
                System.err.println("Error sending temp password: " + e.getMessage());
                e.printStackTrace();
                response.put("error", true);
                response.put("verified", false);
                return ResponseEntity.ok(response);
            }

            // 계정 잠금 해제 및 실패 시도 횟수 초기화
            try {
                System.out.println("Unlocking account and resetting attempts for email: " + email);
                userService.unlockAccountByEmailAndResetAttempts(email);
                System.out.println("Account unlocked and attempts reset.");
            } catch (Exception e) {
                System.err.println("Error unlocking account: " + e.getMessage());
                e.printStackTrace();
                response.put("error", true);
                response.put("verified", false);
                return ResponseEntity.ok(response);
            }
        } else {
            response.put("verified", false);
            System.out.println("Auth code verification failed.");
        }

        System.out.println("Preparing to send response.");
        return ResponseEntity.ok(response);
    }
    
 }
    
	
