let dateInput;
let itemInput;
let moneyInput;
let categoryInput;
let memoInput;

// 입력창 초기 연결
function mInit() {
    dateInput = document.getElementById("mdate");
    itemInput = document.getElementById("mItem");
    moneyInput = document.getElementById("mMoney");
    categoryInput = document.getElementById("mCategory");
    memoInput = document.getElementById("mMemo");
}

// 🗑 버튼 누르면 입력창 전체 초기화
function mReset() {
    if (dateInput) dateInput.value = "";
    if (itemInput) itemInput.value = "";
    if (moneyInput) moneyInput.value = "";
    if (categoryInput) categoryInput.value = "";
    if (memoInput) memoInput.value = "";
}

function validateForm() {
    const incomeRadio = document.getElementById('income');
    const outcomeRadio = document.getElementById('outcome');
    const mdate = document.getElementById('mdate').value.trim();
    const mMoney = document.getElementById('mMoney').value.trim();
    const mCategory = document.getElementById('mCategory').value.trim();
    const mItem = document.getElementById('mItem').value.trim();

    // 수입/지출 체크 여부 검사
    if (!incomeRadio.checked && !outcomeRadio.checked) {
        alert("수입 또는 지출을 선택해주세요.");
        return false;
    }

    if (mdate === "") {
        alert("날짜를 입력해주세요.");
        return false;
    }
    if (mMoney === "") {
        alert("금액을 입력해주세요.");
        return false;
    }
    if (mCategory === "") {
        alert("카테고리를 입력해주세요.");
        return false;
    }
    if (mItem === "") {
        alert("항목을 입력해주세요.");
        return false;
    }

    return true;
}

