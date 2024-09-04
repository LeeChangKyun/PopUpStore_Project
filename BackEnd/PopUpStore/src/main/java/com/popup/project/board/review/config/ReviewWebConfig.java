package com.popup.project.board.review.config;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;
import org.springframework.web.servlet.resource.PathResourceResolver;

@Configuration
public class ReviewWebConfig implements WebMvcConfigurer {
    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:C:/review/uploads/")
                // 브라우저의 캐시 기간을 3600초(1시간)로 설정하여 리소스 로딩 속도를 향상
                .setCachePeriod(3600)
                // 리소스 체인을 활성화하여 추가적인 리소스 핸들링이 가능
                .resourceChain(true)
                // PathResourceResolver를 추가하여 리소스 위치를 해석하는 데 사용
                .addResolver(new PathResourceResolver());
    }
}
