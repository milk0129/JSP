// 모든 expId 체크박스를 전체 선택
function selectAll() {
    const checkboxes = document.querySelectorAll('input[name="expId"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = true;
    });
}

// 모든 expId 체크박스를 전체 해제
function deselectAll() {
    const checkboxes = document.querySelectorAll('input[name="expId"]');
    checkboxes.forEach(checkbox => {
        checkbox.checked = false;
    });
}
