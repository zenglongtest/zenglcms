<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html;charset=UTF-8">
<link rel="stylesheet" type="text/css" href="{zengl theme}/css/db_restore.css" media="screen">
<script type="text/javascript" src="{zengl theme}/js/jquery-1.7.1.js"></script>
<script type="text/javascript" src="{zengl theme}/js/jquery.simplemodal.1.4.2.min.js"></script> 
<script type="text/javascript">
$(document).ready(function() {
		$('#restore_dialog').modal({maxWidth:400});
		$('.restore_yes').click(function(){
			locationStr = '{zengl cms_root_dir}bak_restore_db.php?action={zengl bak_restore_loc}';
			locationStr += '&user=' + $('#username')[0].value;
			locationStr += '&pass=' + $('#password')[0].value;
			if($('#select_db').val() == 0)
				locationStr += '&sqltype=' + 'sqlite';
			else if($('#select_db').val() == 1)
				locationStr += '&sqltype=' + 'mysql';
			location.href = locationStr;
			return false;
		});
	});
</script>
<title>{zengl title}</title>
</head>
<body>
<div id = "maindiv">
<h2>{zengl title}</h2>

<div id='restore_dialog'>
	<p>请输入{zengl title}的用户名和密码：</p>
	user:<input type="text" name="username" id="username" size="30" maxlength="60" /><br/>
	pass:<input type="password" name="password" id="password" size="30" maxlength="60" /><br/>
	<br/>
	当前数据库类型为：
	<select id="select_db">
		{zengl options}
	</select>
	<br/>
	<font color='red'>注意：当备份时，可以在当前数据库类型的下拉列表中选择要备份的数据库格式，如选择sqlite类型，则无论当前数据库是mysql还是sqlite，数据都会保存为sqlite格式，该格式的备份只能用于恢复sqlite数据库，如果恢复mysql就会出错。同理，如果在备份时选择了mysql类型，那么数据将会被保存为mysql格式，该格式只能用于恢复mysql数据库。</font><br/>
	<font color = 'red'>技巧：可以将sqlite数据库备份为mysql格式，再恢复到mysql数据库中，就可以将sqlite数据库的数据转移到mysql中，反之同理。</font>
	<div class='buttons'>
		<div class='restore_no simplemodal-close'>No</div><div class='restore_yes'>Yes</div>
	</div>
</div>

</div>
</body>
</html>