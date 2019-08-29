
component displayname="bdgCalendars" output="false" {
    // INIT
    ///////////////////////////////////////////////////////////////////////////
    remote struct function init(){

        VARIABLES.Instance.structCalendar = structNew();
        VARIABLES.Instance.structCalendar.ID = 0;
        VARIABLES.Instance.structCalendar.bill_id = "";
        VARIABLES.Instance.structCalendar.cal_event_date = "";
        VARIABLES.Instance.structCalendar.cal_date_created = "";
        VARIABLES.Instance.structCalendar.cal_event_name = "";
        VARIABLES.Instance.structCalendar.cal_payment_amount = 0;
        VARIABLES.Instance.structCalendar.bill_name = "";

        return this;
    };

    // GET
    ///////////////////////////////////////////////////////////////////////////

    // Search - return all
    ///////////////////////////////////////////////////////////////////////////
    public any function get_Calendars()
    {
        sql =  "SELECT C.[ID]
                    ,C.[bill_id]
                    ,C.[cal_event_date]
                    ,C.[cal_date_created]
                    ,C.[cal_event_name]
                    ,C.[cal_payment_amount]
                    ,B.[bill_name]
                FROM [budget4me].[dbo].[bdgCalendars] C
                INNER JOIN [budget4me].[dbo].[bdgBills] B
                ON B.ID = C.bill_id";
        qryCalendars = queryExecute(sql,[],{datasource="budget4me"});

        return qryCalendars;
    };
    remote any function getJson_Calendars() returnformat="json"
    {
        return get_Calendars();
    };

    // Search by ID (ID)
    ///////////////////////////////////////////////////////////////////////////
    private struct function get_CalendarById(ID = 0)
    {
        sql =  "SELECT C.[ID]
                    ,C.[bill_id]
                    ,C.[cal_event_date]
                    ,C.[cal_date_created]
                    ,C.[cal_event_name]
                    ,C.[cal_payment_amount]
                    ,B.[bill_name]
                FROM [budget4me].[dbo].[bdgCalendars] C
                INNER JOIN [budget4me].[dbo].[bdgBills] B
                ON B.ID = C.bill_id
                WHERE C.ID = #arguments.ID#";
        qryCalendars = queryExecute(sql,[],{datasource="budget4me"});

        if(qryCalendars.recordcount)
        {
            structCalendar = queryGetRow(qryCalendars,1);
            setVariableInstanceValues(structCalendar);
        }

        return VARIABLES.Instance.structCalendar;
    };
    remote struct function getJson_CalendarById(ID = 0) returnformat="json"
    {
        get_CalendarById(ID = arguments.ID);

        return VARIABLES.Instance.structCalendar;
    };
    // Search by Bill name (bill_id)
    ///////////////////////////////////////////////////////////////////////////
    private struct function get_CalendarByBillName(bill_id = 0)
    {
        sql =  "SELECT C.[ID]
                    ,C.[bill_id]
                    ,C.[cal_event_date]
                    ,C.[cal_date_created]
                    ,C.[cal_event_name]
                    ,C.[cal_payment_amount]
                    ,B.[bill_name]
                FROM [budget4me].[dbo].[bdgCalendars] C
                INNER JOIN [budget4me].[dbo].[bdgBills] B
                ON B.ID = C.bill_id
                WHERE C.bill_id = :bill_id";
        qryCalendars = queryExecute(sql,{autonum=arguments.bill_id},{datasource="budget4me"});

        if(qryCalendars.recordcount)
        {
            structCalendar = queryGetRow(qryCalendars,1);
            setVariableInstanceValues(structCalendar);
        }

        return VARIABLES.Instance.structCalendar;
    };
    remote struct function getJson_CalendarByBillName(bill_id = 0) returnformat="json"
    {
        get_CalendarByBillName(bill_id = arguments.bill_id);

        return VARIABLES.Instance.structCalendar;
    };
    // Search by Bill num (cal_event_date)
    ///////////////////////////////////////////////////////////////////////////
    private struct function get_CalendarByBillNumber(cal_event_date = 0)
    {
        sql =  "SELECT C.[ID]
                    ,C.[bill_id]
                    ,C.[cal_event_date]
                    ,C.[cal_date_created]
                    ,C.[cal_event_name]
                    ,C.[cal_payment_amount]
                    ,B.[bill_name]
                FROM [budget4me].[dbo].[bdgCalendars] C
                INNER JOIN [budget4me].[dbo].[bdgBills] B
                ON B.ID = C.bill_id
                WHERE C.cal_event_date = :cal_event_date";
        qryCalendars = queryExecute(sql,{autonum=arguments.cal_event_date},{datasource="budget4me"});

        if(qryCalendars.recordcount)
        {
            structCalendar = queryGetRow(qryCalendars,1);
            setVariableInstanceValues(structCalendar);
        }

        return VARIABLES.Instance.structCalendar;
    };
    remote struct function getJson_CalendarByBillNumber(cal_event_date = 0) returnformat="json"
    {
        get_CalendarByBillNumber(cal_event_date = arguments.cal_event_date);

        return VARIABLES.Instance.structCalendar;
    };

    // Search by amount (cal_date_created)
    ///////////////////////////////////////////////////////////////////////////
    private struct function get_CalendarByAmount(cal_date_created = 0)
    {
        sql =  "SELECT C.[ID]
                    ,C.[bill_id]
                    ,C.[cal_event_date]
                    ,C.[cal_date_created]
                    ,C.[cal_event_name]
                    ,C.[cal_payment_amount]
                    ,B.[bill_name]
                FROM [budget4me].[dbo].[bdgCalendars] C
                INNER JOIN [budget4me].[dbo].[bdgBills] B
                ON B.ID = C.bill_id
                WHERE C.cal_date_created = :cal_date_created";
        qryCalendars = queryExecute(sql,{autonum=arguments.cal_date_created},{datasource="budget4me"});

        if(qryCalendars.recordcount)
        {
            structCalendar = queryGetRow(qryCalendars,1);
            setVariableInstanceValues(structCalendar);
        }

        return VARIABLES.Instance.structCalendar;
    };
    remote struct function getJson_CalendarByAmount(cal_date_created = 0) returnformat="json"
    {
        get_CalendarByAmount(cal_date_created = arguments.cal_date_created);

        return VARIABLES.Instance.structCalendar;
    };
    // Search by Bill alias (type_id)
    ///////////////////////////////////////////////////////////////////////////
    private struct function get_CalendarByAlias(cal_date_created = 0)
    {
        sql =  "SELECT C.[ID]
                    ,C.[bill_id]
                    ,C.[cal_event_date]
                    ,C.[cal_date_created]
                    ,C.[cal_event_name]
                    ,C.[cal_payment_amount]
                    ,B.[bill_name]
                FROM [budget4me].[dbo].[bdgCalendars] C
                INNER JOIN [budget4me].[dbo].[bdgBills] B
                ON B.ID = C.bill_id
                WHERE C.type_id = :type_id";
        qryCalendars = queryExecute(sql,{autonum=arguments.type_id},{datasource="budget4me"});

        if(qryCalendars.recordcount)
        {
            structCalendar = queryGetRow(qryCalendars,1);
            setVariableInstanceValues(structCalendar);
        }

        return VARIABLES.Instance.structCalendar;
    };
    remote struct function getJson_CalendarByAlias(cal_date_created = 0) returnformat="json"
    {
        get_CalendarByAlias(cal_date_created = 0);

        return VARIABLES.Instance.structCalendar;
    };

    // SET
    ///////////////////////////////////////////////////////////////////////////

    // Pass JSON Obj to Variable.Instance scope
    ///////////////////////////////////////////////////////////////////////////
    remote numeric function set_Bill()
    {   
        init();
        // convert JSON obj to CF struct
        // Then set Variable.Instance scope struct with passed values

        setVariableInstanceValues(DeserializeJSON(form.JSONOBJ));
        
        // If this is new entry create a new table row for it
        if(VARIABLES.Instance.structCalendar.ID == 0 
            || !structKeyExists(variables.Instance.structCalendar,"ID"))
        {   
            VARIABLES.Instance.structCalendar.ID = initTableRow();
        };


        // Update row with Variable.Instance scope data
        sql = " UPDATE [budget4me].[dbo].[bdgCalendars] SET dateAdded = dateAdded " ;
        if(len(VARIABLES.Instance.structCalendar.bill_id) != 0){ 
            sql &= ",bill_id = '#VARIABLES.Instance.structCalendar.bill_id#'" ;
        };
        if(len(VARIABLES.Instance.structCalendar.cal_event_date) != 0){ 
            sql &= ",cal_event_date = '#VARIABLES.Instance.structCalendar.cal_event_date#'" ;
        };
        if(len(VARIABLES.Instance.structCalendar.cal_date_created) != 0){ 
            sql &= ",cal_date_created = '#VARIABLES.Instance.structCalendar.cal_date_created#'" ;
        };
        if(len(VARIABLES.Instance.structCalendar.cal_event_name) != 0){ 
            sql &= ",cal_event_name = '#VARIABLES.Instance.structCalendar.cal_event_name#'" ;
        };
        if(len(VARIABLES.Instance.structCalendar.cal_payment_amount) != 0){ 
            sql &= ",cal_payment_amount = '#VARIABLES.Instance.structCalendar.cal_payment_amount#'" ;
        };

        sql &= " WHERE autonum = #VARIABLES.Instance.structCalendar.ID#";

        queryExecute(sql,[],{datasource="webs"});

        return VARIABLES.Instance.structCalendar.ID;
    };

    // SET Variable.Instance Struct Values
    ///////////////////////////////////////////////////////////////////////////
    private void function setVariableInstanceValues(struct structCalendar)
    {   
        if(structKeyExists(arguments.structCalendar,"ID"))
        {
          VARIABLES.Instance.structCalendar.ID = arguments.structCalendar.ID;  
        }
        if(structKeyExists(arguments.structCalendar,"bill_id"))
        {
           VARIABLES.Instance.structCalendar.bill_id = arguments.structCalendar.bill_id; 
        }
        if(structKeyExists(arguments.structCalendar,"bill_name"))
        {
           VARIABLES.Instance.structCalendar.bill_name = arguments.structCalendar.bill_name; 
        }
        if(structKeyExists(arguments.structCalendar,"cal_event_date"))
        {
          VARIABLES.Instance.structCalendar.cal_event_date = arguments.structCalendar.cal_event_date;  
        }
        if(structKeyExists(arguments.structCalendar,"cal_date_created"))
        {
           VARIABLES.Instance.structCalendar.cal_date_created = arguments.structCalendar.cal_date_created; 
        }
        if(structKeyExists(arguments.structCalendar,"cal_event_name"))
        {
           VARIABLES.Instance.structCalendar.cal_event_name = arguments.structCalendar.cal_event_name; 
        }
        if(structKeyExists(arguments.structCalendar,"cal_payment_amount"))
        {
           VARIABLES.Instance.structCalendar.cal_payment_amount = arguments.structCalendar.cal_payment_amount; 
        }
    }

    // SET table row with null values
    ///////////////////////////////////////////////////////////////////////////
    private numeric function initTableRow()
    {
        sql = " INSERT INTO [dbo].[bdgCalendars]
                    ([bill_id]
                    ,[cal_event_date]
                    ,[cal_date_created]
                    ,[cal_event_name]
                    ,[cal_payment_amount])
                VALUES
                    (NULL
                    ,NULL
                    ,NULL
                    ,NULL
                    ,NULL)
                Select @@IDENTITY as autonum";
        qryNewCalendar = queryGetRow(queryExecute(sql,[],{datasource="webs"}),1);
        
        return qryNewCalendar.autonum;
    }
}