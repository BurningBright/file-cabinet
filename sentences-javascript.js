����������
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

��ֱȡҪ����mapת����~~��
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
			

��each����JQ������󣬻ص�1Ϊindex��2Ϊhtml����
$("#batchBtn").on("click",function(){
	var count = 0;
	$("table td input[type=checkbox]").each(function(i, j) {
		console.log("--"+i+"--"+$(j).val());
		if($(this).is(":checked")) {
			console.log(++count);
		}
	});
});

��Jquery����תDom����
var v=$v[0]

��Dom����תJquery����
var $v=$(v)

var planId = /planId=(\d+)/.test(href) ? RegExp.$1: ''

(function(arg){...})(param);
(function($) {...})(jquery);

var a=function($) {...};
a(jquery);

jQuery(document).ready(function(){ });

//ʱ����-����
$("#TSMGRAM_REALCA_1_birthday").datepicker({
	inline:false,
	dateFormat: "yy-mm-dd",
	dayNames: [ "������", "����һ", "���ڶ�", "������", "������", "������", "������"],
	dayNamesMin: ["��", "һ", "��", "��", "��", "��", "��"],
	monthNamesShort: [ "1��", "2��", "3��", "4��", "5��", "6��", "7��", "8��", "9��", "10��", "11��", "12��" ]
});

//��֤
if( this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) ) ){


$("#TSMGRAM_REALCA_1_realSub").click(function(event){			//�ύʱ���ж�
	event.preventDefault();										//��ֹ�ύ
	var flag = true;
																//�Ա�Ҫ�ֶ������
	$("#TSMGRAM_REALCA_1_form :input.required").each(function(){
		if( $(this).is('#TSMGRAM_REALCA_1_username') ){
			if( this.value.length < 1 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч�û���");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_fullname') ){
			if( this.value.length < 1 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч�û�ȫ��");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_sex') ){
			if( this.value.length < 1 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч�Ա�");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_birthday') ){
			if( this.value=="" ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч����");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_id') ){
			if( this.value.length < 11 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч���֤");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_email') ){
			if( this.value=="" || ( this.value!="" && !/.+@.+\.[a-zA-Z]{2,4}$/.test(this.value) )){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч����");
				return flag = false;
			}
		}
		if( $(this).is('#TSMGRAM_REALCA_1_verify') ){
			if( this.value.length != 4 ){
				$("#TSMGRAM_REALCA_1_msgWapper").text("��Ч��֤��");
				return flag = false;
			}
		}
	});
	
	if( flag ){
		$("#TSMGRAM_REALCA_1_form").submit();
	}
});