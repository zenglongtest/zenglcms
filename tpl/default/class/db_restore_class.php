<?php 
$filetpl = $zengl_cms_tpl_dir . $zengl_theme . '/db_restore.tpl';
$filecache = $zengl_cms_tpl_dir . 'cache/db_restore_cache.php';
if(!file_exists($filetpl))
	die('tpl file '.$filetpl.' does not exist!');

if($sql->db_type != MYSQL && $sql->db_type != SQLITE)
	new error('数据库类型错误','无效的数据库类型',true,true);
if($rvar_action == 'bak')
	$title_type = "备份数据库";
else if($rvar_action == 'restore')
	$title_type = "恢复数据库";
if(file_exists($filecache) && ( filemtime($filecache) > filemtime($filetpl) ) &&
	(filemtime($filecache) > filemtime($zengl_cms_tpl_dir . 'filetpl')) )
{
	include $filecache;
	exit();
}
$tpl = new tpl($filetpl, $filecache);
$tpl->setVar('theme', 'echo $zengl_cms_tpl_dir . $zengl_theme',true);
$tpl->setVar('title', 'echo $title_type',true);
$tpl->setVar('bak_restore_loc', 'echo $rvar_action',true);
$tpl->setVar('options','
		if($sql->db_type == MYSQL)
			echo "<option value=\'" . MYSQL . "\' selected=\'yes\'>mysql</option>" .
				  "<option value=\'" . SQLITE . "\'>sqlite</option>";
		else if($sql->db_type == SQLITE)
			echo "<option value=\'" . MYSQL . "\'>mysql</option>" .
				  "<option value=\'" . SQLITE . "\' selected=\'yes\'>sqlite</option>";
		',true);
$tpl->setVar('cms_root_dir', 'echo $zengl_cms_rootdir;',true);
$tpl->cache();
include $filecache;
exit();
?>