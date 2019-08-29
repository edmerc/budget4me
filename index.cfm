<!--- vvv CF CODE --->
<cfscript>
    // Accounts
    // objAccounts = createObject("component","cfc.bdgAccounts").init();
    // qryAccounts = objAccounts.get_Accounts();
    // Bills
    objBills = createObject("component","cfc.bdgBills").init();
    qryBills = objBills.get_Bills();
    // Calendar
    objCalendars = createObject("component","cfc.bdgCalendars").init();
    qryCalendars = objCalendars.get_Calendars();
    // Types
    objTypes = createObject("component","cfc.bdgTypes").init();
    qryTypes = objTypes.get_Types();
</cfscript>
<!--- ^^^ CF CODE --->
<!DOCTYPE html>
<html lang="en">

  <head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1,
      shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Budget4me 1.0</title>

    <!-- Bootstrap core CSS -->
    <link href="./bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="./bootstrap/custom_css/business-frontpage.css" rel="stylesheet">
    <!--- fontawesome --->
    <link rel="stylesheet" href="./fontawesome/css/all.min.css">
    <!--- jquery-confirm --->
    <link rel="stylesheet" href="./CSS/jquery-confirm.min.css">

  </head>

  <body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
      <div class="container">
        <a class="navbar-brand" href="#">Budgeting 4 your life</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse"
          data-target="#navbarResponsive" aria-controls="navbarResponsive"
          aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarResponsive">
          <ul class="navbar-nav ml-auto">
            <li class="nav-item active">
              <a class="nav-link" href="#">Home
                <span class="sr-only">(current)</span>
              </a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">About</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Services</a>
            </li>
            <li class="nav-item">
              <a class="nav-link" href="#">Contact</a>
            </li>
          </ul>
        </div>
      </div>
    </nav>

    <!-- Header -->
    <header class="bg-primary py-3 mb-3">
      <div class="container h-20">
        <div class="row h-20 align-items-center">
          <div class="col-lg-12">
            <h1 class="display-4 text-white mt-5 mb-2">Budget4me 1.0</h1>
            <p class="lead mb-5 text-white-50">Manage and schedule your payments
              without having to think about when they're due.</p>
          </div>
        </div>
      </div>
    </header>

    <!-- Page Content -->
    <div class="container">

      <div class="row">
        <div class="col-md-4 mb-5">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title">Manage Accounts</h4>
              <p class="card-text">All your accounts, organized in one place.</p>
              <table class="table" id="tblAccounts">
                <tr>
                    <th>Name</th>
                    <th>Alias</th>
                    <th>Edit</th>
                </tr>  
                <tbody>
                </tbody>          
              </table>
            </div>
            <div class="card-footer">
              <button type="button" id="btnOpenAccountModal" class="btn btn-primary">Add Account</button>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-5">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title">Manage Bills</h4>
              <p class="card-text">Amounts due and when.</p>
              <table class="table" id="tblBills">
                <tr>
                  <th>Name</th>
                  <th>Min Amt</th>
                  <th>Edit</th>
                </tr>
                <cfoutput query="qryBills">
                    <tr>
                        <td>#bill_name#</td>
                        <td>#bill_amount#</td>
                        <td><a class="loadBillData" id="bill_#id#" title="Edit"><i class="far fa-edit text-primary" id="i_#id#"></i></a></td>
                    </tr>
                </cfoutput>
              </table>
            </div>
            <div class="card-footer">
              <button id="btnOpenBillsModal" class="btn btn-primary">Add Bill</button>
            </div>
          </div>
        </div>
        <div class="col-md-4 mb-5">
          <div class="card h-100">
            <div class="card-body">
              <h4 class="card-title">Manage Events</h4>
              <p class="card-text">Pay by dates. Payday dates.</p>
              <table class="table" id="tblCal">
                <tr>
                  <th>Event Name</th>
                  <th>Date</th>
                  <th>Edit</th>
                </tr>
                  

                <cfoutput query="qryCalendars">
                    <tr>
                        <td>#cal_event_name#</td>
                        <td>#cal_event_date#</td>
                        <td><a class="loadCalData" id="cal_#id#" title="Edit"><i class="far fa-edit text-primary" id="i_#id#"></i></a></td>
                    </tr>
                </cfoutput>
              </table>
            </div>
            <div class="card-footer">
              <button id="btnOpenCalModal" class="btn btn-primary">Add Event</button>
            </div>
          </div>
        </div>
      </div>
      <!-- /.row -->

    </div>
    <!-- /.container -->

    <!-- Footer -->
    <footer class="py-5 bg-dark">
      <div class="container">
        <p class="m-0 text-center text-white">Copyright &copy; Budget4me 2019</p>
      </div>
      <!-- /.container -->
    </footer>

    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <!--                                                        modals -->
    <!-- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -->
    <!-- Account modal/////////////////////////////////////////////////// -->
      <div class="modal fade" id="modalAccount" tabindex="-1" role="dialog"
      aria-labelledby="modalAccount" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title float-left">Accounts</h4>
            <button type="button" class="close" data-dismiss="modal"
              aria-hidden="true">&times;</button>            
          </div>
          <!-- /.modal-header -->
          <div class="modal-body">
            <form id="formAccount" class="form-horizontal">
              <input type="hidden" id="fldAccountId">
              <div class="form-group">
                <label class="col-xs-4 control-label">Name</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldAccountName">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Alias</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldAccountAlias">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Account#</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldAccountNum">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Debt Amt.</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldAccountAmt">
                </div>
              </div>
            </form>
          </div>
          <!-- /.modal-body -->
          <div class="modal-footer">
            <span class="text-left">
              <button type="button" id="btnAccountDelete" class="btn
              btn-danger">Delete</button>
            </span> 
            <button type="button" id="btnAccountUpdate" class="btn
              btn-success btn-user-edit">Save</button>
            <button type="button" class="btn btn-primary
              btn-matrix-cancel" data-dismiss="modal">Close</button>
          </div>
          <!-- /.modal-footer -->
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>

    <!-- bills modal/////////////////////////////////////////////////// -->
    <div class="modal fade" id="modalBills" tabindex="-1" role="dialog"
      aria-labelledby="modalBills" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title float-left">Bills</h4>
            <button type="button" class="close" data-dismiss="modal"
              aria-hidden="true">&times;</button>
          </div>
          <!-- /.modal-header -->

          <div class="modal-body">
            <form class="form-horizontal">
              <input type="hidden" name="fldBillAccountID" id="fldBillAccountID"/>
              <div class="form-group">
                <label class="col-xs-4 control-label">Name</label>
                <div class="col-xs-8">
                  <input class="form-control" type="text"
                    name="fldBillName" id="fldBillName">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Type</label>
                <div class="col-xs-8">
                  <input type="hidden" class="form-control"
                    name="fldBillType" id="fldBillType">
                    <input type="text" class="form-control"
                    name="fldBillTypeName" id="fldBillTypeName">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Min. Amt.</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    name="fldBillAmount" id="fldBillAmount">
                </div>
              </div>
            </form>
          </div>
          <!-- /.modal-body -->

          <div class="modal-footer">
            <button type="button" id="btnBillsUpdate" class="btn
              btn-primary btn-user-edit">Save</button>
            <button type="button" class="btn btn-danger
              btn-matrix-cancel" data-dismiss="modal">Close</button>
          </div>
          <!-- /.modal-footer -->
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>
    <!-- calendar modal/////////////////////////////////////////////////// -->
    <div class="modal fade" id="modalCal" tabindex="-1" role="dialog"
      aria-labelledby="modalCal" aria-hidden="true">
      <div class="modal-dialog">
        <div class="modal-content">
          <div class="modal-header">
            <h4 class="modal-title float-left">Calendar</h4>
            <button type="button" class="close" data-dismiss="modal"
              aria-hidden="true">&times;</button>
          </div>
          <!-- /.modal-header -->

          <div class="modal-body">
            <form class="form-horizontal">
              <input type="hidden" name="fldCalBillId" id="fldCalBillId"/>
              <div class="form-group">
                <label class="col-xs-4 control-label">Event Name</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldCalEventName" name="fldCalEventName">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Bill Name</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldCalBillName" name="fldCalBillName">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Event Date</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldCalEventDate" name="fldCalEventDate">
                </div>
              </div>
              <div class="form-group">
                <label class="col-xs-4 control-label">Payment Amt.</label>
                <div class="col-xs-8">
                  <input type="text" class="form-control"
                    id="fldCalPaymentAmt">
                </div>
              </div>
            </form>
          </div>
          <!-- /.modal-body -->

          <div class="modal-footer">
            <button type="button" id="btnCalUpdate" class="btn
              btn-primary btn-user-edit">Save</button>
            <button type="button" class="btn btn-danger
              btn-matrix-cancel" data-dismiss="modal">Close</button>
          </div>
          <!-- /.modal-footer -->
        </div>
        <!-- /.modal-content -->
      </div>
      <!-- /.modal-dialog -->
    </div>

  </body>
</html>

<!--- //////////////////////////////// --->
<!-- Bootstrap core JavaScript -->
<!--- //////////////////////////////// --->
<script src="./node_modules/jquery/dist/jquery.min.js"></script>
<script src="./node_modules/jquery/dist/jquery-confirm.min.js"></script>
<script src="./bootstrap/js/bootstrap.min.js"></script>
<script src="JS/PageFunctions.js"></script>
