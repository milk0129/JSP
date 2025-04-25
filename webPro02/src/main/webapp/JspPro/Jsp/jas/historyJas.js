let change;
let excel;
let result = "";

function mInit(){
    change = document.getElementById("bank");
    excel = document.getElementById("calander");

	date = document.getElementById("mdate");
	input = document.getElementById("minput");
	money = document.getElementById("mmoney");
	category = document.getElementById("mcategory");
	memo = document.getElementById("mmemo");
}

function mMoney(){
    if (change.value == "입금")	{
        change.value = "출금";
    } else if (change.value == "출금")	{
        change.value = "입금";
    }
}

function mShow(){
    if (excel.value == "엑셀")	{
        excel.value = "달력";
    } else if (excel.value == "달력")	{
        excel.value = "엑셀";
    }
}

function mSave(){
	if(date.value != "" && input.value != "" && money.value != "" && category.value != "" && memo.value != ""){
		result += date.value + " / " + input.value + " / " + money.value + " / " + category.value + " / " + memo.value + "<br>";
		document.getElementById("demo").innerHTML = result;
		mReset();
	} else
		alert("빈 칸을 채워주세요");
}

function mReset(){
	date.value = "";
	input.value = "";
	money.value = "";
	category.value = "";
	memo.value = "";
}