<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<footer class="text-white">
    <div class="footer-nav">
        <!-- 이용약관 모달 트리거 -->
        <a href="#" data-bs-toggle="modal" data-bs-target="#termsModal">이용약관</a>
        <!-- 개인정보처리방침 모달 트리거 -->
        <a href="#" data-bs-toggle="modal" data-bs-target="#privacyModal">개인정보처리방침</a>
    </div>
    <div class="footertext" style="color: #4e4f4e;">
        <p>셀러브리지 | 대표 김군호 | 팝업코리아 사업본부장 정혜원</p>
        <p>주소 서울특별시 서초구 강남대로 373, 위워크 강남 15-111호</p>
        <p>사업자등록번호 278-88-02399 | 통신판매업신고번호 제2022-서울서초-2059 호</p>
        <p>핸드폰 010-9696-3674 | 이메일 popupkorea@seller-bridge.com</p>
        <p>© 셀러브리지 All rights reserved.</p>
    </div>
</footer>

<!-- 이용약관 모달 -->
<div class="modal fade" id="termsModal" tabindex="-1" aria-labelledby="termsModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="termsModalLabel">이용약관</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img src="../../image/Member/terms.png" alt="이용약관" class="img-fluid" style="max-width: 100%; height: auto;">
            </div>
        </div>
    </div>
</div>

<!-- 개인정보처리방침 모달 -->
<div class="modal fade" id="privacyModal" tabindex="-1" aria-labelledby="privacyModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-fullscreen">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="privacyModalLabel">개인정보처리방침</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <img src="../../image/Member/privacy.png" alt="개인정보처리방침" class="img-fluid" style="max-width: 100%; height: auto;">
            </div>
        </div>
    </div>
</div>
