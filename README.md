# 🗺️ FORTRIP (나만의 여행 코스 공유 플랫폼)

**FORTRIP**는 사용자가 직접 만든 여행 코스를 공유하고, 다른 사람의 코스를 참고해 나만의 여행을 설계할 수 있는 플랫폼입니다.  
여행 준비 과정에서 느꼈던 불편함을 해결하고, 즐거운 경험을 함께 나누기 위해 개발되었습니다.  

---

## 📌 선정 이유
많은 사람들이 여행 계획을 세울 때 블로그나 SNS 후기를 참고하지만,  
정보가 체계적이지 않고 개인적 경험에 치우쳐 불편을 겪습니다.  
이 프로젝트는 사용자가 직접 코스를 등록·공유하고, 다른 사람이 이를 참고하여 쉽게 여행을 준비할 수 있도록 돕습니다.  
또한 Spring과 Kakao API를 접목해 **위치 기반 코스 표시**와 **간편한 사용자 경험**을 제공하는 것을 목표로 합니다.  

---

## 🚀 주요 기능
- 회원가입 / 로그인 (카카오 소셜 로그인 지원)
- 여행 코스 등록, 수정, 삭제
- 지도 기반 여행지 위치 표시 (Kakao Map API)
- 코스 검색 (지역, 키워드, 태그)
- 좋아요 / 찜하기 / 공유
- 리뷰 및 별점 평가

---

## 🛠 기술 스택
- **Backend** : Spring MVC, MyBatis  
- **Frontend** : JSP, JSTL, Bootstrap  
- **Database** : Oracle / MySQL  
- **API** : Kakao Login API, Kakao Map API  
- **ETC** : Maven, Tomcat, GitHub  

---

## 📂 프로젝트 구조
```
src
├─ main
│ ├─ java
│ │ └─ com.project.ForTrip
│ │ ├─ controller
│ │ ├─ service
│ │ ├─ dao
│ │ └─ vo
│ ├─ resources
│ │ └─ mappers
│ └─ webapp
│ ├─ WEB-INF
│ │ └─ views
│ └─ resources
│ ├─ css
│ ├─ jsp
│ └─ img
└─ test
```
