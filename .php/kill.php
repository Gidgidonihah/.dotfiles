<?php

function jweir_kill(){
	$args = func_get_args();
	foreach($args as $arg){
		if($arg === 'die') exit();

		echo("<pre style='border: 1px solid skyblue; padding: 10px; margin 10px; text-align: left;'>");
		print_r( $arg );
		echo("</pre>\n");
	}
}

function var_jweir_kill(){
	$args = func_get_args();
	foreach($args as $arg){
		if($arg === 'die') exit();

		echo("<pre style='border: 1px solid skyblue; padding: 10px; margin 10px; text-align: left;'>");
		var_dump( $arg );
		echo("</pre>\n");
	}
}

