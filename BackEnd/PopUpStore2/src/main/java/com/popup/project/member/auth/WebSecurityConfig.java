package com.popup.project.member.auth;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.security.web.firewall.HttpFirewall;
import org.springframework.security.web.firewall.StrictHttpFirewall;

import com.popup.project.member.service.CustomUserDetailsService;
import com.popup.project.member.service.CustomOAuth2UserService;

import jakarta.servlet.DispatcherType;
import jakarta.servlet.http.HttpServletResponse;

@Configuration
public class WebSecurityConfig {

    @Autowired
    private RedirectAuthenticatedUserFilter redirectAuthenticatedUserFilter;

    @Autowired
    private CustomUserDetailsService customUserDetailsService;

    @Autowired
    public MyAuthFailureHandler myAuthFailureHandler;

    @Autowired
    private CustomOAuth2UserService customOAuth2UserService;

    @Bean
    public BCryptPasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    public DaoAuthenticationProvider authenticationProvider() {
        DaoAuthenticationProvider authProvider = new DaoAuthenticationProvider();
        authProvider.setUserDetailsService(customUserDetailsService);
        authProvider.setPasswordEncoder(passwordEncoder());
        return authProvider;
    }

    @Bean
    public AuthenticationSuccessHandler customAuthenticationSuccessHandler() {
        return (request, response, authentication) -> {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();
            if (userDetails.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
                response.sendRedirect("/Admin/Home?adminLogin=true");
            } else {
                response.sendRedirect("/");
            }
        };
    }
    
    @Bean
    public AuthenticationSuccessHandler customOAuth2AuthenticationSuccessHandler() {
        return (request, response, authentication) -> {
            CustomUserDetails userDetails = (CustomUserDetails) authentication.getPrincipal();

            // 소셜 사용자 정보 입력 여부에 따라 리디렉션
            if (userDetails.getUser().getUserNick() == null || userDetails.getUser().getUserNick().isEmpty()) {
                response.sendRedirect("/SocialForm");
            } else {
                response.sendRedirect("/");
            }
        };
    }
    

    @Bean
    public SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        http.addFilterBefore(redirectAuthenticatedUserFilter, UsernamePasswordAuthenticationFilter.class)
            .securityContext(securityContext -> securityContext
                .securityContextRepository(new HttpSessionSecurityContextRepository())
            )
            .sessionManagement(session -> session
                .sessionCreationPolicy(SessionCreationPolicy.IF_REQUIRED)
            )
            .csrf(csrf -> csrf.disable())
            .authorizeHttpRequests(request -> request
                .dispatcherTypeMatchers(DispatcherType.FORWARD).permitAll()
                .requestMatchers("/Admin/**").hasRole("ADMIN")
                .requestMatchers("/Member/**").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/promotionList", "/promotionWrite", "/promotionView").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/inquiryWrite", "/promotionWrite").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/promotionList", "/promotionWrite", "/promotionView").hasAnyRole("USER", "ADMIN")
                .requestMatchers("/", "/register_form", "/register", "/IdCheck", "/NickCheck", "/EmailCheck", "/PhoneCheck").permitAll()
                .requestMatchers("/SocialForm").permitAll()
                .requestMatchers("/**", "/FindId", "/FindIdPw", "/FindPwAuth").permitAll()
                .requestMatchers("/CheckUserId", "/CheckNameEmail").permitAll()
                .requestMatchers("/css/**", "/js/**", "/image/**").permitAll()
                .requestMatchers("/Guest/auth/Login").permitAll()
                .requestMatchers("/Guest/**").permitAll()
                .requestMatchers("/Map").permitAll()
                .requestMatchers(HttpMethod.POST, "/Member/profile/Withdraw").permitAll()
                .anyRequest().authenticated()
            )
            .formLogin(formLogin -> formLogin
                .usernameParameter("userName")
                .passwordParameter("userPwd")
                .loginPage("/Guest/auth/Login")
                .loginProcessingUrl("/Login")
                .failureUrl("/Guest/auth/Login?error=true")
                .successHandler(customAuthenticationSuccessHandler())
                .permitAll()
            )
            .logout(logout -> logout
                .logoutUrl("/Logout.do")
                .logoutSuccessUrl("/")
                .permitAll()
            )
            .exceptionHandling(expHandling -> expHandling
                .authenticationEntryPoint((request, response, authException) -> {
                    if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                        response.sendError(HttpServletResponse.SC_UNAUTHORIZED, "Unauthorized");
                    } else {
                        response.sendRedirect("/Guest/auth/Login");
                    }
                })
                .accessDeniedPage("/denied.do")
            )
            .oauth2Login(oauth2 -> oauth2
                .loginPage("/Guest/auth/Login")
                .defaultSuccessUrl("/SocialForm", true)
                .failureUrl("/Guest/auth/Login?error=true")
                .userInfoEndpoint(userInfo -> userInfo
                    .userService(customOAuth2UserService)  // Custom OAuth2UserService 설정
                )
            );

        http.authenticationProvider(authenticationProvider());

        return http.build();
    }

    @Bean
    public HttpFirewall allowUrlEncodedSlashHttpFirewall() {
        StrictHttpFirewall firewall = new StrictHttpFirewall();
        firewall.setAllowUrlEncodedDoubleSlash(true);
        return firewall;
    }
}