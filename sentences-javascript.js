【函数链】
function monkey(banana){
	console.log("i'm a monkey");
	var count = 0;
	var timer = setInterval(function(){
			if(count++<2) {
				console.log(count);
				console.log("i have " + banana +"  bananas");	
			} else {
				clearInterval(timer);
			}
		},1000);
}
function banana() { return 10;}
(function(a) {
	monkey(a);
})(banana());

【直取要害，map转换流~~】
var count = 0;
var channelId = new Array();
var resultId = new Array();
$("table td input[type=checkbox]:not(:disabled)").each(function() {
	if($(this).is(":checked")) {
		//console.log(++count);
		channelId.push(parseInt($(this).val()));
		resultId.push(parseInt($(this).attr('resultId')));
		count++;
	}
});
//console.log(channelId.toString()+" "+resultId.toString());

var channels = $("table td input[type=checkbox]:not(:disabled):checked").map(function(){
	return $(this).val();
}).get();
var results = $("table td input[type=checkbox]:not(:disabled):checked").map(function(){
	return $(this).attr('resultId');
}).get();
			

【each迭代JQ数组对象，回调1为index，2为html对象】
$("#batchBtn").on("click",function(){
	var count = 0;
	$("table td input[type=checkbox]").each(function(i, j) {
		console.log("--"+i+"--"+$(j).val());
		if($(this).is(":checked")) {
			console.log(++count);
		}
	});
});

【Jquery对象转Dom对象】
var v=$v[0]

【Dom对象转Jquery对象】
var $v=$(v)

var planId = /planId=(\d+)/.test(href) ? RegExp.$1: ''

(function(arg){...})(param);
(function($) {...})(jquery);

var a=function($) {...};
a(jquery);

jQuery(document).ready(function(){ });

//时间插件-中文
$("#TSMGRAM_REALCA_1_birthday").datepicker({
	inline:false,
	dateFormat: "yy-mm-dd",
	dayNames: [ "星期天", "星期一", "星期二", "星期三", "星期四", "星期五", "星期六"],
	dayNamesMin: ["日", "一", "二", "三", "四", "五", "六"],
	monthNamesShort: [ "1月", "2月", "3月", "4月", "5月", "6月", "7月", "8月", "9月", "10月", "11月", "12月" ]
});

//验证
if( this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) ) ){


$("#TSMGRAM_REALCA_1_realSub").click(function(event){			//提交时做判断
	event.preventDefault();										//阻止提交
	var flag = true;
																//对必要字段做检查
	$("#TSMGRAM_REALCA_1_form :input.required").each(function(){
		if( $(this).is('#TSMGRAM_REALCA_1_username') ){
			if( this.value.length < 1 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效用户名");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_fullname') ){
			if( this.value.length < 1 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效用户全称");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_sex') ){
			if( this.value.length < 1 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效性别");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_birthday') ){
			if( this.value=="" ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效生日");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_id') ){
			if( this.value.length < 11 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效身份证");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_email') ){
			if( this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) )){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效邮箱");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_verify') ){
			if( this.value.length != 4 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("无效验证码");
				return flag = false;
			}
		}
	});
	
	if( flag ){
		$("#TSMGRAM_REALCA_1_form").submit();
	}
});