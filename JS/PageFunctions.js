let data = {};
// ///////////////////////////////////
// on document load
// ///////////////////////////////////
$(function () {
    data = {
        // data tables
        tblAccounts: $('#tblAccounts'),
        tblBills: $('#tblBills'),
        tblCal: $('#tblCal'),
        // data rows
        // rowAccount: $('#tblAccounts > tbody:last-child'),
        // modal windows
        modalAccount: $('#modalAccount'),
        modalBills: $('#modalBills'),
        modalCal: $('#modalCal'),
        // modalAccount 
        formAccount: $('#formAccount'),
        fldAccountId: $('#fldAccountId'),
        fldAccountName: $('#fldAccountName'),
        fldAccountAlias: $('#fldAccountAlias'),
        fldAccountNum: $('#fldAccountNum'),
        fldAccountAmt: $('#fldAccountAmt'),
        // modalBills fields
        fldBillAccountID: $('#fldBillAccountID'),
        fldBillName: $('#fldBillName'),
        fldBillAmount: $('#fldBillAmount'),
        fldBillType: $('#fldBillType'),
        fldBillTypeName: $('#fldBillTypeName'),
        // modalCal fields
        fldCalBillId: $('#fldCalBillId'),
        fldCalEventName: $('#fldCalEventName'),
        fldCalEventDate: $('#fldCalEventDate'),
        fldCalPaymentAmt: $('#fldCalPaymentAmt'),
        fldCalBillName: $('#fldCalBillName'),
        // buttons
        btnOpenAccountModal: $('#btnOpenAccountModal'),
        btnOpenBillsModal: $('#btnOpenBillsModal'),
        btnOpenCalModal: $('#btnOpenCalModal'),
        btnAccountDelete: $('#btnAccountDelete'),
        btnAccountUpdate: $('#btnAccountUpdate'),
        btnBillsUpdate: $('#btnCalUpdate'),
        btnCalUpdate: $('#btnCalUpdate'),
        // links
        loadBillData: $('.loadBillData'),
        loadCalData: $('.loadCalData')
    };

    account_data = {
        account_id: 0,
        account_name: "",
        account_alias: "",
        account_num: "",
        account_amount: 0
    };
    bill_data = {
        bill_account_id: 0,
        bill_name: '',
        bill_amount: 0,
        bill_type_id: 0,
        bill_type_name: ''
    };
    cal_data = {
        cal_id: 0,
        cal_bill_id: 0,
        cal_bill_name: "",
        cal_event_date: "",
        cal_date_created: "",
        cal_event_name: "",
        cal_payment_amount: 0
    };
    // ///////////////////////////////////
    // // bind buttons
    // ///////////////////////////////////
    $(data.btnOpenAccountModal).on("click", function () {
        clearModalAccount();
        openModal(modalAccount);
    });
    $(data.btnOpenBillsModal).on("click", function () {
        clearModalBills();
        openModal(modalBills);
    });
    $(data.btnOpenCalModal).on("click", function () {
        openModal(modalCal);
    });
    $(data.btnAccountDelete).on("click", function () {
        deleteAccountConfirm();
    });
    $(data.btnAccountUpdate).on("click", function () {
        writeNewAccount();
        closeModal(modalAccount);
    });
    $(data.btnBillsUpdate).on("click", function () {
        closeModal(modalBills);
    });
    $(data.btnCalUpdate).on("click", function () {
        closeModal(modalCal);
    });
    $(data.loadBillData).on("click", function (e) {
        loadBillData(e);
    });
    $(data.loadCalData).on("click", function (e) {
        loadCalData(e);
    });
    getAccounts();
    return this;
});
// ///////////////////////////////////
// open / close modals
// ///////////////////////////////////
function openModal(modal_name) {
    $(modal_name).modal('show');
};

function closeModal(modal_name) {
    $(modal_name).modal('hide');
};

// ///////////////////////////////////
// manage account modal data
// ///////////////////////////////////
function clearAccountData() {
    $('#tblAccounts > tbody:last-child').empty();
};

function loadAccountData(obj) {
    console.log(obj);
    clearAccountData();
    let new_row = "";
    $.each(obj.DATA, function (key, value) {
        new_row = `<tr><td> ${value[1]} </td><td> ${value[4]} </td><td><a class = 'loadDetailedAccountData' id = 'account_${value[0]}' title = 'Edit'><i class = 'far fa-edit text-primary' id = 'i_${value[0]}'></i></a></td></tr></a>`;
        $('#tblAccounts > tbody:last-child').append(new_row);
    });
    bindAccountEditButtons();
};

function loadDetailedAccountData(e) {
    let aryId = e.target.id.split("_");
    let id = aryId[1];
    getAccountById(id);
};

function getAccounts() {
    $.ajax({
        url: "cfc/bdgAccounts.cfc?method=getJson_Accounts",
        method: "POST",
        dataType: "json"
    })
        .done(function (data) {
            loadAccountData(JSON.parse(data.responseText));
        })
        .fail(function (jqXHR, textStatus) {
            $.alert({
                title: 'Alert!',
                content: `Request failed: ${textStatus}`
            });
        });
};

function getAccountById(id) {
    let request = $.ajax({
        url: "cfc/bdgAccounts.cfc?method=getJson_AccountById",
        method: "POST",
        data: {
            ID: id
        },
        dataType: "json"
    });
    request.done(function (msg) {
        openModal(modalAccount);
        setModalAccountData(JSON.parse(request.responseText));
        writeToModalAccount();
    });
    request.fail(function (jqXHR, textStatus) {
        $.alert({
            title: 'Alert!',
            content: `Request failed: ${textStatus}`
        });
    });
};

function setModalAccountData(obj) {
    account_data = {
        account_id: obj.ID,
        account_name: obj.ACCOUNT_NAME,
        account_num: obj.ACCOUNT_NUM,
        account_amount: obj.ACCOUNT_AMOUNT,
        account_alias: obj.ACCOUNT_ALIAS
    };
};

function writeToModalAccount() {
    data.fldAccountId.val(account_data.account_id);
    data.fldAccountName.val(account_data.account_name);
    data.fldAccountAlias.val(account_data.account_alias);
    data.fldAccountNum.val(account_data.account_num);
    data.fldAccountAmt.val(account_data.account_amount);
};

function clearModalAccount() {
    data.fldAccountId.val(0);
    data.fldAccountName.val('');
    data.fldAccountAlias.val('');
    data.fldAccountNum.val('');
    data.fldAccountAmt.val('');
};

function writeNewAccount() {
    grabFormAccount();
    let request = $.ajax({
        url: "cfc/bdgAccounts.cfc?method=set_account",
        method: "POST",
        data: account_data
    });
    request.done(function (msg) {
        getAccounts();
    });
    request.fail(function (jqXHR, textStatus) {
        $.alert({
            title: 'Alert!',
            content: `Request failed: ${textStatus}`
        });
    });
};

function grabFormAccount() {
    account_data = {
        account_id: data.fldAccountId.val(),
        account_name: data.fldAccountName.val(),
        account_num: data.fldAccountNum.val(),
        account_amount: data.fldAccountAmt.val(),
        account_alias: data.fldAccountAlias.val()
    };
};

function deleteAccountConfirm() {
    grabFormAccount();
    $.confirm({
        theme: 'supervan',
        title: 'Delete account?',
        content: 'This dialog will automatically trigger \'cancel\' in 6 seconds if you don\'t respond.',
        autoClose: 'cancelAction|8000',
        buttons: {
            deleteAccount: {
                text: 'delete account',
                action: function () {
                    deleteAccount(account_data.account_id);
                },
            },
            cancelAction: function () {
                $.alert({
                    title: 'Canceled.',
                    content: 'Action has been canceled.'
                });
            },
        },
    });
};

function deleteAccount(id) {
    let request = $.ajax({
        url: "cfc/bdgAccounts.cfc?method=deleteAccountById",
        method: "POST",
        data: {
            ID: id
        },
        dataType: "html"
    });
    request.done(function () {
        $.alert({
            title: 'Delete confirmation',
            content: 'Account deleted.'
        });
        closeModal('modalAccount');
        getAccounts();
    });
    request.fail(function (jqXHR, textStatus) {
        $.alert({
            title: 'Alert!',
            content: `Request failed: ${textStatus}`
        });
    });
};

// ///////////////////////////////////
// manage bill modal data    
// ///////////////////////////////////
function loadBillData(e) {
    let aryId = e.target.id.split("_");
    let id = aryId[1];
    let request = $.ajax({
        url: "cfc/bdgBills.cfc?method=getJson_BillById",
        method: "POST",
        data: {
            ID: id
        },
        dataType: "json"
    });
    request.done(function (msg) {
        openModal(modalBills);
        setModalBillsData(JSON.parse(request.responseText));
        writeToModalBills();

    });
    request.fail(function (jqXHR, textStatus) {
        $.alert({
            title: 'Alert!',
            content: `Request failed: ${textStatus}`
        });
    });
};

function setModalBillsData(obj) {
    bill_data = {
        bill_account_id: obj.ACCOUNT_ID,
        bill_name: obj.BILL_NAME,
        bill_amount: obj.BILL_AMOUNT,
        bill_type_id: obj.TYPE_ID,
        bill_type_name: obj.TYPE_NAME
    };
};

function writeToModalBills() {
    data.fldBillName.val(bill_data.bill_name);
    data.fldBillAmount.val(bill_data.bill_amount);
    data.fldBillType.val(bill_data.bill_type_id);
    data.fldBillTypeName.val(bill_data.bill_type_name);
};

function clearModalBills() {
    data.fldBillName.val('');
    data.fldBillAmount.val('');
    data.fldBillType.val('');
    data.fldBillTypeName.val('');
};

// ///////////////////////////////////
// manage Calendar modal data    
// ///////////////////////////////////
function loadCalData(e) {
    let aryId = e.target.id.split("_");
    let id = aryId[1];
    let request = $.ajax({
        url: "cfc/bdgCalendars.cfc?method=getJson_CalendarById",
        method: "POST",
        data: {
            ID: id
        },
        dataType: "json"
    });
    request.done(function (msg) {
        openModal(modalCal);
        setModalCalData(JSON.parse(request.responseText));
        writeToModalCal();

    });
    request.fail(function (jqXHR, textStatus) {
        $.alert({
            title: 'Alert!',
            content: `Request failed: ${textStatus}`
        });
    });
};

function setModalCalData(obj) {
    cal_data = {
        cal_id: obj.ID,
        cal_bill_id: obj.BILL_ID,
        cal_event_date: obj.CAL_EVENT_DATE,
        cal_date_created: obj.CAL_DATE_CREATED,
        cal_event_name: obj.CAL_EVENT_NAME,
        cal_payment_amount: obj.CAL_PAYMENT_AMOUNT,
        cal_bill_name: obj.BILL_NAME
    };
};

function writeToModalCal() {
    data.fldCalEventName.val(cal_data.cal_event_name);
    data.fldCalBillName.val(cal_data.cal_bill_name);
    data.fldCalEventDate.val(cal_data.cal_event_date);
    data.fldCalPaymentAmt.val(cal_data.cal_payment_amount);
};

function clearModalCal() {
    data.fldCalEventName.val('');
    data.fldCalBillName.val('');
    data.fldCalEventDate.val('');
    data.fldCalPaymentAmt.val('');
};

// ///////////////////////////////////
// INIT    
// ///////////////////////////////////
function bindAccountEditButtons() {
    $('.loadDetailedAccountData').on("click", function (e) {
        loadDetailedAccountData(e);
    });
};