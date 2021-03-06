<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link rel="stylesheet" type="text/css" href="{zengl theme}/css/style.css" media="screen">
<link rel="stylesheet" type="text/css" href="{zengl theme}/css/admin_list_replys.css" media="screen">
<!--<link rel="stylesheet" type="text/css" href="{zengl theme}/css/tip-darkgray.css" media="screen"> -->
<link rel="stylesheet" type="text/css" href="{zengl theme}/css/tip-yellowsimple.css" media="screen">
<script type="text/javascript" src="{zengl theme}/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="{zengl theme}/js/jquery.paginate.js"></script> 
<script type="text/javascript" src="{zengl theme}/js/jquery.simplemodal.1.4.2.min.js"></script> 
<script type="text/javascript" src="{zengl theme}/js/jquery.poshytip.min.js"></script> 
<script type="text/javascript" src="{zengl theme}/js/jquery.tablesorter.min.js"></script> 
<script type="text/javascript">
$(document).ready(function() {
	$('#selectAll').click(function(){
					$('.checkID').attr('checked',true);
					$('.checkID').parent().parent().css('background-color', '#f389ca');
					return false;
						});
	$('#unselect').click(function(){
					$('.checkID').attr('checked',false);
					$('.checkID').parent().parent().css('background-color', '');
					return false;
						});
	$('.checkID').click(function(){
					if($(this)[0].checked)
					{
						$(this).parent().parent().css('background-color', '#f389ca');
					}
					else
						$(this).parent().parent().css('background-color', '');
					});
	clickdel_href = '';
	$('#del_dialog').hide();
	$('.del_reply').click(function(){
					delStr = '您要删除以下回复吗：<br/>';
					delStr += $(this).parent().parent().find('.reply_sm_content_td').text();
					$('#del_dialog p').html(delStr);
					clickdel_href = $(this).attr("href");
					$('#del_dialog').modal({maxWidth:400});
					return false;
				});
	$('#multidel').click(function(){
					delStr = '您要删除以下回复吗：<br/>';
					clickdel_href = "{zengl cms_root_dir}comment_operate.php?action=multidel_replys";
					checknum = $('.checkID').size();
					count = 0;
					replyidStr = '';
					articleidStr = '';
					for(i=0;i<checknum;i++)
					{
						if($('.checkID:eq('+i+')')[0].checked)
						{
							delStr += '(id:' + $('.checkID:eq('+i+')')[0].value + ') 内容:' + $('.reply_sm_content_td:eq('+i+')').text() + '<br/>';
							if(count == 0)
							{
								replyidStr += '&replyID=' + $('.checkID:eq('+i+')')[0].value;
								articleidStr += '&articleID=' + $('.articleID:eq('+i+')')[0].value;
							}
							else
							{
								replyidStr += ',' + $('.checkID:eq('+i+')')[0].value;
								articleidStr += ',' + $('.articleID:eq('+i+')')[0].value;
							}
							count++;
						}
					}
					clickdel_href += replyidStr + articleidStr;
					$('#del_dialog p').html(delStr);
					$('#del_dialog').modal({maxWidth:400});
					return false;
						});
	$('.yes').click(function(){
					if(clickdel_href != '')
						location.href = clickdel_href;
					return false;
				});
	$('#set_reply_list').click(function(){
					valnum = $('#reply_list_num')[0].value;
					if(isNaN(valnum) || valnum == '')
					{
						alert("必须是数字");
						return false;
					}
					location.href = "{zengl cms_root_dir}comment_operate.php?action=admin_set_reply_num"+
										"&replyNum="+valnum;
					return false;
				});
	$('.comment_sm_content_td').poshytip({
					//className: 'tip-darkgray',
					className: 'tip-yellowsimple',
					bgImageFrameSize: 11,
					offsetX: -25 
				});
	$('.reply_sm_content_td').poshytip({
					//className: 'tip-darkgray',
					className: 'tip-yellowsimple',
					bgImageFrameSize: 11,
					offsetX: -25 
				});
	sec_pagenum = {zengl sec_PageNum};
	if(sec_pagenum > 0)
			$("#pages").paginate({ 
				        count    : {zengl sec_PageNum} {zengl sec_query}, 
				        start    : {zengl startPage}, 
				        display  : {zengl sec_DisplaySize}, 
				        text_color				  : 'white',
				        background_color        : 'black',
				        text_hover_color          : 'white', 
				        background_hover_color    : 'red',
				        images                    : false, 
				        mouse                    : 'press', 
				        onChange      : function(sec_page){ 
					        					location.href = "{zengl cms_root_dir}comment_operate.php?action=admin_reply_list&sec_page="+sec_page+
					        										{zengl page_change};
				                     		} 
	    					}); 
	    					
	  $(".widelink_content a,#set_reply_list").prepend("&nbsp;&nbsp;").append("&nbsp;&nbsp;");
	  $(".widelink a").prepend("&nbsp;&nbsp;").append("&nbsp;&nbsp;");
	  $("#replys table tr").hover(function(){
				$(this).addClass("td_hover");
				$(this).find("a").css({"color":'#fff'});
			},function(){
				$(this).removeClass("td_hover");
				$(this).find("a").css({"color":'#000'});
		});
	  $('.reply_table').tablesorter(); 
	  $('#buttom_op div').hover(function(){
			$(this).css({"background":'url({zengl theme}/images/admin_list_articles_css_img/greengradient.png) repeat-x',"color":'#fff'});
			$(this).find("a").css({"color":'#fff'});
		},function(){
			$(this).css({"background":'url({zengl theme}/images/admin_list_articles_css_img/graygradient.png) top left repeat-x',"color":'#000'});
			$(this).find("a").css({"color":'#000'});
		});
	});
</script>
<title>{zengl title}</title>
</head>
<body>
<div id = "maindiv">
	<div id="header_title">{zengl title}</div>
	<input type='text' value='{zengl reply_list_num}' id='reply_list_num' size='5' />&nbsp;&nbsp;
	<a href='#' id='set_reply_list'>设置显示数目</a> &nbsp;&nbsp; 当前:{zengl current_num}/共:{zengl totalnum}
	<div class="replys">
		<div id="replys" class = 'widelink_content'>
			<table class='reply_table'>
				<thead> 
					<tr align='center'><th width="70">回复ID&nbsp;&nbsp;&nbsp;&nbsp;</th><th width="60">选择&nbsp;&nbsp;&nbsp;&nbsp;</th><th>回复内容&nbsp;&nbsp;&nbsp;&nbsp;</th><th>所属评论&nbsp;&nbsp;&nbsp;&nbsp;</th><th>所属文章&nbsp;&nbsp;&nbsp;&nbsp;</th><th width="120">所属用户&nbsp;&nbsp;&nbsp;&nbsp;</th><th width="100">回复昵称&nbsp;&nbsp;&nbsp;&nbsp;</th><th width="150">回复时间&nbsp;&nbsp;&nbsp;&nbsp;</th><th  width="60">操作&nbsp;&nbsp;&nbsp;&nbsp;</th></tr>
				</thead> 
				<tbody> 
				{zengl for_replys}
				<tr>
					<td align='center' class='reply_td' >{zengl reply_id}</td>
					<td align='center' class='reply_td'><input type="checkbox" class="checkID" value="{zengl reply_id}"></td>
					<td class='reply_td'><a href={zengl reply_a} target='_blank' title={zengl reply_content} class = 'reply_sm_content_td'>
						{zengl reply_small_content}</a></td>
					<td class='reply_td'><a href={zengl comment_a} title={zengl comment_content} class = 'comment_sm_content_td'>
						{zengl comment_small_content}</a></td>
					<td class='reply_td'><a href={zengl article_title_a} title={zengl article_tip} class = 'article_title_a'>{zengl article_title}</a></td>
					<td class='reply_td'><a href={zengl username_a}>{zengl username}</a></td>
					<td class='reply_td'><a href={zengl nickname_a}>{zengl nickname}</a></td>
					<td class='reply_td'>{zengl time}</td>
					<td class='reply_td'><a href={zengl reply_del} class='del_reply' title="删除"><img src="{zengl theme}/images/admin_list_articles_css_img/del.jpg" width="23"></a></td>
					<td class='reply_td'><input class='articleID' type='hidden' value="{zengl articleID}" /></td>
				</tr>
				{zengl endfor}
				</tbody> 
			</table>
		</div>
		<div id="buttom_op" class = 'widelink'>
			<div id='selectAll'>全选</div>
			<div id='unselect'>取消选择</div>
			<div id='multidel'>批量删除</div>
		</div>
		<div id="buttom_op_clear"></div>
		<div id="pages"></div>
	</div>
	
	<div id='del_dialog'>
		<p>你确定要删除回复吗?</p>
		<div class='buttons'>
			<div class='no simplemodal-close'>No</div><div class='yes'>Yes</div>
		</div>
	</div>
</div>
</body>
</html>