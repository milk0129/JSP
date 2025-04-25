# Personal Finance Tracker (가계부 프로젝트)

프론트엔드와 백엔드를 연결하여 구현한 JSP 기반의 개인 가계부 관리 웹 애플리케이션입니다.  
사용자는 회원가입 및 로그인 후, 지출 내역을 입력/수정/조회할 수 있습니다.

## 📁 프로젝트 구조

src/
└── main/
    ├── java/
    │   ├── common/
    │   │   └── commonPro/
    │   │       ├── DbClose.java
    │   │       └── DbSet.java
    │   ├── memJSP/
    │   └── proJSP/
    │       ├── ExpenseDAO.java
    │       ├── ExpenseDTO.java
    │       ├── UserDAO.java
    │       └── UserDTO.java
    │
    └── webapp/
        └── book01JSP/
            └── JspPro/
                └── Jsp/
                    ├── css/
                    │   ├── HistoryCss.css
                    │   ├── loginstyle.css
                    │   ├── mainCss.css
                    │   ├── mainMenu.css
                    │   └── outline.css
                    │
                    ├── historyJsp/
                    │   ├── historyAdd.html
                    │   ├── historyDelete.html
                    │   └── historyUpdate.html
                    │
                    ├── img/
                    ├── jas/
                    │   └── historyJas.js
                    │
                    ├── mainJsp/
                    │   ├── home.jsp
                    │   ├── index.jsp
                    │   ├── mainAfter.html
                    │   └── outline.html
                    │
                    └── userJsp/
                        ├── find-id.jsp
                        ├── login.jsp
                        └── signUp.jsp
                        
## ⚙️ 사용 기술

- **Frontend**: HTML5, CSS3, JavaScript (Vanilla)
- **Backend**: JSP, Servlet, Java DAO/DTO 패턴
- **Database**: Oracle DB (JDBC 연동)

## 🧪 주요 기능

- 회원가입 및 로그인 기능
- ID 찾기 기능 (이름 + 생년월일 기반)
- 지출 내역 입력 / 수정 / 확인
- 총 지출 금액 계산 및 출력                        
