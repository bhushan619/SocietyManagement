<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Society.master" AutoEventWireup="true" CodeFile="Yearwisepayment.aspx.cs" Inherits="Society_Reports_Yearwisepayment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script src="http://www.google.com/jsapi" type="text/javascript"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
        $(function () {
            $.ajax({
                type: 'POST',
                dataType: 'json',
                contentType: 'application/json',
                url: 'Yearwisepayment.aspx/GetChartData',
                data: '{}',
                success:
                    function (response) {
                        drawChart(response.d);
                    },

                error: function () {
                    alert("Error loading data! Please try again.");
                }
            });
        })
      google.charts.load('current', {'packages':['bar']});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart(dataValues) {
           
          var data = new google.visualization.DataTable();

          // Declare columns
          data.addColumn('string', 'Year');
          data.addColumn('number', 'Recieved Amount');
          data.addColumn('number', 'Outstanding Amount');

          for (var i = 0; i < dataValues.length; i++) {
              data.addRow([dataValues[i].year, dataValues[i].amount, dataValues[i].outamount]);
          }
           
        var options = {
            chart: {
                title: 'Yearwise Payment Details',
            },
          bars: 'horizontal' // Required for Material Bar Charts.
        };

        var chart = new google.charts.Bar(document.getElementById('barchart_material'));

        chart.draw(data, options);
      }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="row">
    <div class="col-md-12">
    <div id="barchart_material" ></div>
        </div>
        </div>
</asp:Content>

