# Personal Finance Tracker (가계부 프로젝트)

프론트엔드와 백엔드를 연결하여 구현한 JSP 기반의 개인 가계부 관리 웹 애플리케이션입니다.  
사용자는 회원가입 및 로그인 후, 지출 내역을 입력/수정/조회할 수 있습니다.

## 📁 프로젝트 폴더 구조

- `src/main/java/common/commonPro/`  
  - DB 설정 관련 클래스 (`DbSet.java`, `DbClose.java` 등)

- `src/main/java/proJSP/`  
  - DAO 및 DTO 클래스 (`UserDAO`, `ExpenseDAO`, `UserDTO`, `ExpenseDTO`)

- `src/main/webapp/book01JSP/JspPro/Jsp/`  
  - 프론트 리소스 모음
    - `css/`: 스타일 시트
    - `historyJsp/`: 지출 내역 관련 HTML
    - `mainJsp/`: 메인 페이지 관련 JSP
    - `userJsp/`: 로그인, 회원가입 관련 JSP
    - `jas/`: JS 파일
               
## ⚙️ 사용 기술

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: JSP, Servlet, Java DAO/DTO 패턴
- **Database**: Oracle DB (JDBC 연동)

## 🧪 주요 기능

- 회원가입 및 로그인 기능
- ID 찾기 기능 (이름 + 생년월일 기반)
- 지출 내역 입력 / 수정 / 확인
- 총 지출 금액 계산 및 출력                        
