$(document).ready(function() {
		// Date Range Picker

		$('#daterangepicker1').daterangepicker();


		$('#daterangepicker2').daterangepicker({
		ranges: {
			'Today': [moment(), moment()],
			'Yesterday': [moment().subtract('days', 1), moment().subtract('days', 1)],
			'Last 7 Days': [moment().subtract('days', 6), moment()],
			'Last 30 Days': [moment().subtract('days', 29), moment()],
			'This Month': [moment().startOf('month'), moment().endOf('month')],
			'Last Month': [moment().subtract('month', 1).startOf('month'), moment().subtract('month', 1).endOf('month')]
		},
		opens: 'left',
		startDate: moment().subtract('days', 29),
		endDate: moment()
		},
		function(start, end) {
			$('#daterangepicker2 span').html(start.format('MMMM D, YYYY') + ' - ' + end.format('MMMM D, YYYY'));
		});

		$('#daterangepicker3').daterangepicker({ timePicker: true, timePickerIncrement: 30, format: 'dd-mm-yyyy h:mm A' });


		//Color Picker
		$('.cpicker').colorpicker();

		//Eternicode Datepicker
		$("#ContentPlaceHolder1_txtDateofJoin").datepicker({ todayHighlight: true });
		$("#ContentPlaceHolder1_txtDOB").datepicker({ todayHighlight: true });
		$("#ContentPlaceHolder1_txtStartDate").datepicker({ todayHighlight: true });
		$("#ContentPlaceHolder1_txtEndDate").datepicker({ todayHighlight: true });
		$('#datepicker-pastdisabled').datepicker({
			todayHighlight: true,
	    	startDate: "-3d",
	    	endDate: "+3d"
		});
		$('#datepicker-startview').datepicker({
			todayHighlight: true,
	    	startView: 1
		});
		$('#datepicker-inline').datepicker({todayHighlight: true});
		$('#datepicker-range').datepicker({todayHighlight: true});

		//m3wolf Time Picker
		$('#timepicker1').timepicker();
		$('#timepicker2').timepicker({
			minuteStep: 5,
	        showInputs: false,
	        disableFocus: true
		}); 
		$('#timepicker3').timepicker({
	        template: false,
	        showInputs: false,
	        minuteStep: 5
	    });


	    //Clockface
		$('#t1').clockface();  
		$('#t2').clockface({
	        format: 'HH:mm',
	        trigger: 'manual'
	    });
	    $('#toggle-btn').click(function(e){   
	        e.stopPropagation();
	        $('#t2').clockface('toggle');
	    });

	    $('#t3').clockface({
        	format: 'H:mm'
    	}).clockface('show', '14:30')


    	//malot.fr Date Time Picker

		$('#dtp-1, #dtp-2, #dtp-4').datetimepicker({format: 'yyyy-mm-dd hh:ii:ss'});

	    $("#dtp-3").datetimepicker({
	        format: "dd MM yyyy - hh:ii:ss",
	        showMeridian: true
	    });

	    $('#dtp-5').datetimepicker({  // Date
	    	format: "dd MM yyyy",
	    	weekStart: 1,
        	todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 2,
			minView: 2,
			forceParse: 0
	    });

		$('#dtp-6').datetimepicker({ // Time
			format: "hh:ii:ss",
        	weekStart: 1,
        	todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: 1,
			minView: 0,
			maxView: 1,
			forceParse: 0
	    });
		$('#ContentPlaceHolder1_txtStartTime').datetimepicker({ // Time
		    format: "hh:ii:ss",
		    weekStart: 1,
		    todayBtn: 1,
		    autoclose: 1,
		    todayHighlight: 1,
		    startView: 1,
		    minView: 0,
		    maxView: 1,
		    forceParse: 0
		});

		$('#ContentPlaceHolder1_txtEndTime').datetimepicker({ // Time
		    format: "hh:ii:ss",
		    weekStart: 1,
		    todayBtn: 1,
		    autoclose: 1,
		    todayHighlight: 1,
		    startView: 1,
		    minView: 0,
		    maxView: 1,
		    forceParse: 0
		});
		$('.input-group-addon .fa-th').removeClass('fa fa-th').addClass('ti ti-view-grid');
		$('.input-group-addon .fa-close').removeClass('fa fa-close').addClass('ti ti-close');
		$('.input-group-addon .fa-clock-o').removeClass('fa fa-clock-o').addClass('ti ti-time');
		$('.input-group-addon .fa-calendar').removeClass('fa fa-calendar').addClass('ti ti-calendar');

});