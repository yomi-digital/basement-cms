<?php

include('inc/initialize.php');
?>
<!DOCTYPE HTML>
<html>
<?php include('layout/header.php'); ?>

<body>
	<div class="bmt-container">
		<?php include('layout/menu.php'); ?>
		<div class="bmt-page-header">
			<?php echo $bmt_locales['dashboard']['menu']; ?>
		</div>
		<div class="bmt-page" style="padding:50px 0 0 0;">
			<?php if (datastudio_url == '' || datastudio_url == 'datastudio_url') { ?>
				<div style="padding:60px 300px">
					Please setup a Google Datastudio URL in your .env file to see the analytics.
				</div>
			<?php } else { ?>
				<iframe width="100%" id="analytics" style="padding-left:250px;" height="1200" src="<?php echo datastudio_url; ?>" frameborder="0" style="border:0" allowfullscreen></iframe>
			<?php } ?>
		</div>
	</div>
	<?php include('layout/footer.php'); ?>

</body>

</html>