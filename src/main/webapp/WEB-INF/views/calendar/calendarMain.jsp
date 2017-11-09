<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>
<div class="col-lg-3"></div>
<div id="main-content-wrapper" class="col-lg-6">
	<div class="content">
		<div class="main-header">
			<h2>Calendar</h2>
			<em>event calendar with drag &amp; drop feature</em>
		</div>
		<div class="main-content">
			<!-- WIDGET CALENDAR -->
			<div class="widget">
				<div class="widget-header">
					<h3><i class="fa fa-calendar"></i> Calendar</h3></div>
				<div class="widget-content">
					<!-- external events -->
					<div id="external-events">
						<div class="row">
							<div class="col-md-6">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">Create Quick Event</h3></div>
									<div class="panel-body">
										<input type="text" class="form-control" id="quick-event-name" placeholder="new event title">
										<select name="colorpicker-picker-longlist">
											<option value="#ac725e">#ac725e</option>
											<option value="#d06b64">#d06b64</option>
											<option value="#f83a22">#f83a22</option>
											<option value="#fa573c">#fa573c</option>
											<option value="#ff7537">#ff7537</option>
											<option value="#ffad46" selected="selected">#ffad46</option>
											<option value="#42d692">#42d692</option>
											<option value="#16a765">#16a765</option>
											<option value="#7bd148">#7bd148</option>
											<option value="#b3dc6c">#b3dc6c</option>
											<option value="#fbe983">#fbe983</option>
											<option value="#fad165">#fad165</option>
											<option value="#92e1c0">#92e1c0</option>
										</select>
										<button type="button" id="btn-quick-event" class="btn btn-custom-primary btn-block"><i class="fa fa-plus-square"></i> Create</button>
									</div>
								</div>
							</div>
							<div class="col-md-6">
								<div class="panel panel-default">
									<div class="panel-heading">
										<h3 class="panel-title">Draggable Events</h3></div>
									<div class="panel-body">
										<div id="event1" class="external-event">Seminar</div>
										<div id="event2" class="external-event">Jane's Birthday</div>
										<div id="event3" class="external-event">Coffee Break</div>
										<div id="event4" class="external-event">Fitness</div>
										<div id="event5" class="external-event">Buy Some Foods</div>
										<div id="event6" class="external-event">Weekly Meeting</div>
										<div id="event7" class="external-event">Monthly Meeting</div>
										<br />
										<label class="control-inline fancy-checkbox">
											<input type="checkbox" id="drop-remove">
											<span>Remove event after drop</span>
										</label>
									</div>
								</div>
							</div>
						</div>
					</div>
					<!-- end external events -->
					<div class="calendar"></div>
				</div>
			</div>
			<!-- END WIDGET CALENDAR -->
		</div>
	</div>
</div>
<div class="col-lg-3"></div>