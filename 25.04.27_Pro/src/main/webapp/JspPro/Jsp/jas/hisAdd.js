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

    const incomeRadio = document.getElementById('income');
    const outcomeRadio = document.getElementById('outcome');

    if (incomeRadio) incomeRadio.checked = false;
    if (outcomeRadio) outcomeRadio.checked = false;
}


function validateForm() {
    const incomeRadio = document.getElementById('income');
    const outcomeRadio = document.getElementById('outcome');
    const mdate = document.getElementById('mdate').value.trim();
    const mMoney = document.getElementById('mMoney').value.trim();
    const mCategory = document.getElementById('mCategory').value.trim();
    const mItem = document.getElementById('mItem').value.trim();
    const resultMsg = document.getElementById('resultMsg');

    if (!incomeRadio.checked && !outcomeRadio.checked) {
        resultMsg.innerText = "수입 또는 지출을 선택해주세요.";
        return false;
    }
    if (mdate === "") {
        resultMsg.innerText = "날짜를 입력해주세요.";
        return false;
    }
    if (mMoney === "") {
        resultMsg.innerText = "금액을 입력해주세요.";
        return false;
    }
    if (mCategory === "") {
        resultMsg.innerText = "카테고리를 입력해주세요.";
        return false;
    }
    if (mItem === "") {
        resultMsg.innerText = "항목을 입력해주세요.";
        return false;
    }

    resultMsg.innerText = ""; // 모든 검사 통과하면 메시지 초기화
    return true;
}

