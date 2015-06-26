{* Smarty *}
{* debug.tpl, console version by Hipska, tweaked by GarrickCheung and Gidgidonihah *}
{assign_debug_info}
{capture assign=debug_output}
	<!doctype html>
	<html>
		<head>
			<title>Smarty Debug Console</title>
			{literal}
			<style>
				body					{ background: #fff; }
				body, h1, h2, td, th, p { font-family: sans-serif; font-size: 0.9em; font-weight: normal; margin: 0; padding: 0; text-align: left; }
				h1{
					background: #565D6D;
					background: -webkit-gradient(linear, left top, left bottom, color-stop(0%,#565D6D), color-stop(86%,#41444B), color-stop(92%,#404145), color-stop(94%,#45464A), color-stop(100%,#68696E));
					background: -webkit-linear-gradient(top, #565D6D 0%,#41444B 86%,#404145 92%,#45464A 94%,#68696E 100%);
					background: -moz-linear-gradient(top, #565D6D 0%, #41444B 86%, #404145 92%, #45464A 94%, #68696E 100%);
					background: -o-linear-gradient(top, #565D6D 0%,#41444B 86%,#404145 92%,#45464A 94%,#68696E 100%);
					background: -ms-linear-gradient(top, #565D6D 0%,#41444B 86%,#404145 92%,#45464A 94%,#68696E 100%);
					background: linear-gradient(top, #565D6D 0%,#41444B 86%,#404145 92%,#45464A 94%,#68696E 100%);
					color: white; font-size: 1.2em; font-weight: 700; margin: 0; padding: .5em 1em;
				}
				h2{
					background: #EDEDEE;
					background-image: -webkit-gradient(linear, left top, left bottom, from(whiteSmoke), to(#E6E5E5));
					background-image: -webkit-linear-gradient(top, whiteSmoke, #E6E5E5);
					background-image: -moz-linear-gradient(top, whiteSmoke, #E6E5E5);
					background-image: -ms-linear-gradient(top, whiteSmoke, #E6E5E5);
					background-image: -o-linear-gradient(top, whiteSmoke, #E6E5E5);
					background-image: linear-gradient(top, whiteSmoke, #E6E5E5);
					color: #87A3C6; font-size: 1em; font-weight: bold; padding: .75em 1em;
				}
				table 					{ border-collapse: collapse; margin: 1em auto; width: 98%; }
				th, td 					{ border: 1px solid #ccc; padding: .25em; vertical-align: top; width: 50%; }
				td 						{ color: green; }
				.exectime 				{ font-size: 0.8em; font-style: italic; }
				#table_assigned_vars th { color: #376C98; }
				#table_config_vars th 	{ color: maroon; }

				#files					{ border: 1px solid #ccc; border-width: 1px 0; margin: 0; padding: .5em; text-align: center; }
				#files > div			{ color: brown; }
				#files > .template		{ color: black; }
				#files > .insert		{ color: green; }
			</style>
			{/literal}
		</head>
		<body>
			<h1>Smarty Debug Console</h1>

			<h2>Included Templates &amp; Config Files (load time in seconds)</h2>
			<div id="files">
				{section name=templates loop=$_debug_tpls}
					{section name=indent loop=$_debug_tpls[templates].depth}&nbsp;&nbsp;&nbsp;{/section}
					<div class="{$_debug_tpls[templates].type}">
						{$_debug_tpls[templates].filename|escape:html}
						{if isset($_debug_tpls[templates].exec_time)}
							<span class="exectime">
								({$_debug_tpls[templates].exec_time|string_format:"%.5f"})
								{if %templates.index% eq 0}(total){/if}
							</span>
						{/if}
					</div>
				{sectionelse}
					no templates included
				{/section}
			</div>

			<h2>Assigned Template Variables</h2>
			<table id="table_assigned_vars">
				<tbody>
					{section name=vars loop=$_debug_keys}
						<tr class="{cycle values="odd,even"}">
							<th>{ldelim}${$_debug_keys[vars]|escape:'html'}{rdelim}</th>
							<td>{$_debug_vals[vars]|@debug_print_var}</td></tr>
					{sectionelse}
						<tr><td><p>no template variables assigned</p></td></tr>
					{/section}
				</tbody>
			</table>

			<h2>Assigned Config File Variables (outer template scope)</h2>
			<table id="table_config_vars">
				<tbody>
					{section name=config_vars loop=$_debug_config_keys}
						<tr class="{cycle values="odd,even"}">
							<th>{ldelim}#{$_debug_config_keys[config_vars]|escape:'html'}#{rdelim}</th>
							<td>{$_debug_config_vals[config_vars]|@debug_print_var}</td></tr>
					{sectionelse}
						<tr><td><p>no config vars assigned</p></td></tr>
					{/section}
				</tbody>
			</table>
		</body>
	</html>
{/capture}
{if isset($_smarty_debug_output) and $_smarty_debug_output eq "html"}
	{$debug_output|escape:'javascript'}
{else}
	<script>
		var Smarty_debug = function(collapsed){ldelim}
			{literal}
				window.smarty = {}
				var group = function(param){
					if(collapsed){
						console.groupCollapsed (param);
					}else{
						console.group(param);
					}
				}
			{/literal}

			group("Smarty Debug");
			console.log('Smarty_debug() to view this information. Smarty_Popup() to view the Smarty Debug Console window');

			group("Included templates & config files");
			{section name=templates loop=$_debug_tpls}
				 console.log("{$_debug_tpls[templates].filename|escape:javascript}{if isset($_debug_tpls[templates].exec_time)} - {$_debug_tpls[templates].exec_time|string_format:"%.5f"}{if %templates.index% eq 0} (total){/if}{/if}");
			{sectionelse}
				 console.info("no templates included");
			{/section}
			console.groupEnd();

			group("Assigned template variables");
			{section name=vars loop=$_debug_keys}
				window.smarty['{$_debug_keys[vars]|escape:'javascript'}'] = {$_debug_vals[vars]|@json_encode};
				console.log("{ldelim}${$_debug_keys[vars]|escape:'javascript'}{rdelim}:", {$_debug_vals[vars]|@json_encode});
			{sectionelse}
				 console.info("no template variables assigned");
			{/section}
			console.groupEnd();
			console.log('Template Variables: ', window.smarty);

			group("Assigned config file variables");
			{section name=config_vars loop=$_debug_config_keys}
				 console.log("{ldelim}#{$_debug_config_keys[config_vars]|escape:'javascript'}#{rdelim}:", {$_debug_config_vals[config_vars]|@json_encode});
			{sectionelse}
				 console.info("no config file variables assigned");
			{/section}
			console.groupEnd();

			console.groupEnd();
			return "Smarty version {$smarty.version}";

		{rdelim};
		var Smarty_Popup = function(){ldelim}
			_smarty_console = window.open("",'Smarty Debug Console',"width=680,height=600,resizable,scrollbars=yes");
			_smarty_console.document.write('{$debug_output|escape:'javascript'}');
			_smarty_console.document.close();
		{rdelim};
		Smarty_debug(true);
	</script>
{/if}
