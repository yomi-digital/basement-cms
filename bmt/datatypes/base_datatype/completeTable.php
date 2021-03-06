<div class="portlet box blue">
	<div class="portlet-body" style="display: block;">
		<table id="dataTable" class="table table-striped table-bordered table-hover">
			<thead>
				<tr>
					<?php
					foreach ($custom_datatypes as $field) {
						$instructions = returnFieldInstructions($field['Comment']);
						if ($instructions['print'] == '1') { ?>
							<th><?php echo returnFieldLabel($field['Field']); ?></th>
					<?php
						}
					}
					?>
					<th style="text-align:center"><i class="fa fa-edit"></i></th>
				</tr>
			</thead>
			<tbody>
				<?php if (count($row_rs_all) > 0) {
					foreach ($row_rs_all as $row) { ?>
						<tr>
							<?php
							foreach ($custom_datatypes as $field) {
								$instructions = returnFieldInstructions($field['Comment']);
								if ($instructions['print'] == '1') {
									if (strpos($field['Field'], 'email') !== false) { ?>
										<td><a href="mailto:<?php echo $row[$field['Field']]; ?>"><?php echo $row[$field['Field']]; ?></a></td>
									<?php } else { ?>
										<td><?php echo returnCorrectDatatypePrintField($instructions['type'], $row[$field['Field']], $instructions['specs'], $instructions['multiple']); ?></td>
							<?php
									}
								}
							}
							?>
							<td style="text-align:center; width:60px">
								<a href="/bmt/<?php echo $internal_route; ?>/<?php echo $row['id']; ?>/modifica" class="bmt-small-button"><i class="fa fa-edit"></i></a>
							</td>
						</tr>
				<?php }
				} ?>
			</tbody>
		</table>
	</div>
	<!--portlet-body-->
</div>
<!--portlet-->