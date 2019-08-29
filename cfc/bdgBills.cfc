
component displayname="bdgBills" output="false" {
    // INIT
    ///////////////////////////////////////////////////////////////////////////
    remote struct function init(){

        VARIABLES.Instance.structBill = structNew();
        VARIABLES.Instance.structBill.ID = 0;
        VARIABLES.Instance.structBill.bill_id = 0;
        VARIABLES.Instance.structBill.bill_name = "";
        VARIABLES.Instance.structBill.bill_amount = 0;
        VARIABLES.Instance.structBill.type_id = 0;
        VARIABLES.Instance.structBill.type_name = '';
        VARIABLES.Instance.structBill.account_id = 0;

        return this;
    };

    // GET
    ///////////////////////////////////////////////////////////////////////////

    // Search - return all
    ///////////////////////////////////////////////////////////////////////////
    public any function get_Bills()
    {
        sql =  "SELECT [ID]
                    ,[account_id]
                    ,[bill_name]
                    ,[bill_amount]
                    ,[type_id]
                    ,[date_added]
                FROM [budget4me].[dbo].[bdgBills]";
        qryBill = queryExecute(sql,[],{datasource="budget4me"});

        return qryBill;
    };
    remote any function getJson_Bills() returnformat="json"
    {
        return get_Bills();
    };

    // Search by ID (ID)
    ///////////////////////////////////////////////////////////////////////////
    remote struct function getJson_BillById(ID = 0) returnformat="json"
    {
        get_BillById(ID = arguments.ID);

        return VARIABLES.Instance.structBill;
    };    
    private void function get_BillById(ID = 0)
    {
        sql =  "SELECT 
                 B.[ID]
                ,B.[account_id]
                ,B.[bill_name]
                ,B.[bill_amount]
                ,B.[type_id]
                ,B.[date_added]
                ,T.[type_name]
                FROM [budget4me].[dbo].[bdgBills] B
                INNER JOIN [budget4me].[dbo].[bdgTypes] T
                ON T.ID = B.type_id
                WHERE B.ID = #arguments.ID#";
        qryBill = queryExecute(sql,[],{datasource="budget4me"});
        structBill = queryGetRow(qryBill,1);
        setVariableInstanceValues(structBill);
    };
    // Search by Bill name (bill_id)
    ///////////////////////////////////////////////////////////////////////////
    remote struct function getJson_BillByBillName(bill_id = 0) returnformat="json"
    {
        get_BillByBillName(bill_id = arguments.bill_id);

        return VARIABLES.Instance.structBill;
    };    
    public struct function get_BillByBillName(bill_name = "")
    {
        sql =  "SELECT [ID]
                    ,[account_id]
                    ,[bill_name]
                    ,[bill_amount]
                    ,[type_id]
                    ,[date_added]
                FROM [budget4me].[dbo].[bdgBills]
                WHERE bill_name = :bill_name";
        qryBill = queryExecute(sql,{autonum=arguments.bill_name},{datasource="budget4me"});

        if(qryBill.recordcount)
        {
            structBill = queryGetRow(qryBill,1);
            setVariableInstanceValues(structBill);
        }

        return VARIABLES.Instance.structBill;
    };

    // Search by account id (account_id)
    ///////////////////////////////////////////////////////////////////////////
    remote struct function getJson_BillByAccountId(account_id = 0) returnformat="json"
    {
        get_BillByAccountId(account_id = arguments.account_id);

        return VARIABLES.Instance.structBill;
    };    
    public struct function get_BillByAccountId(account_id = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_id]
                    ,[bill_name]
                    ,[bill_amount]
                    ,[type_id]
                    ,[date_added]
                FROM [budget4me].[dbo].[bdgBills]
                WHERE account_id = :account_id";
        qryBill = queryExecute(sql,{autonum=arguments.account_id},{datasource="budget4me"});

        if(qryBill.recordcount)
        {
            structBill = queryGetRow(qryBill,1);
            setVariableInstanceValues(structBill);
        }

        return VARIABLES.Instance.structBill;
    };


    // Search by amount (bill_amount)
    ///////////////////////////////////////////////////////////////////////////
    remote struct function getJson_BillByAmount(bill_amount = 0) returnformat="json"
    {
        get_BillByAmount(bill_amount = arguments.bill_amount);

        return VARIABLES.Instance.structBill;
    };
    public struct function get_BillByAmount(bill_amount = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_id]
                    ,[bill_name]
                    ,[bill_amount]
                    ,[type_id]
                    ,[date_added]
                FROM [budget4me].[dbo].[bdgBills]
                WHERE bill_amount = :bill_amount";
        qryBill = queryExecute(sql,{autonum=arguments.bill_amount},{datasource="budget4me"});

        if(qryBill.recordcount)
        {
            structBill = queryGetRow(qryBill,1);
            setVariableInstanceValues(structBill);
        }

        return VARIABLES.Instance.structBill;
    };

    // Search by Bill Type (type_id)
    ///////////////////////////////////////////////////////////////////////////
    remote struct function getJson_BillByType(type_id = 0) returnformat="json"
    {
        get_BillByType(type_id = 0);

        return VARIABLES.Instance.structBill;
    };    
    public struct function get_BillByType(type_id = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_id]
                    ,[bill_name]
                    ,[type_id]
                    ,[date_added]
                FROM [budget4me].[dbo].[bdgBills]
                WHERE type_id = :type_id";
        qryBill = queryExecute(sql,{autonum=arguments.type_id},{datasource="budget4me"});

        if(qryBill.recordcount)
        {
            structBill = queryGetRow(qryBill,1);
            setVariableInstanceValues(structBill);
        }

        return VARIABLES.Instance.structBill;
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
        if(VARIABLES.Instance.structBill.ID == 0 
            || !structKeyExists(variables.Instance.structBill,"ID"))
        {   
            VARIABLES.Instance.structBill.ID = initTableRow();
        };


        // Update row with Variable.Instance scope data
        sql = " UPDATE [budget4me].[dbo].[bdgBills] SET dateAdded = dateAdded " ;
        if(len(VARIABLES.Instance.structBill.account_id) != 0){ 
            sql &= ",account_id = '#VARIABLES.Instance.structBill.account_id#'" ;
        };
        if(len(VARIABLES.Instance.structBill.bill_id) != 0){ 
            sql &= ",bill_id = '#VARIABLES.Instance.structBill.bill_id#'" ;
        };
        if(len(VARIABLES.Instance.structBill.bill_name) != 0){ 
            sql &= ",bill_name = '#VARIABLES.Instance.structBill.bill_name#'" ;
        };
        if(len(VARIABLES.Instance.structBill.bill_amount) != 0){ 
            sql &= ",bill_amount = '#VARIABLES.Instance.structBill.bill_amount#'" ;
        };
        if(len(VARIABLES.Instance.structBill.type_id) != 0){ 
            sql &= ",type_id = '#VARIABLES.Instance.structBill.type_id#'" ; 
        };
        if(len(VARIABLES.Instance.structBill.type_name) != 0){ 
            sql &= ",type_name = '#VARIABLES.Instance.structBill.type_name#'" ; 
        };
        sql &= " WHERE autonum = #VARIABLES.Instance.structBill.ID#";

        queryExecute(sql,[],{datasource="webs"});

        return VARIABLES.Instance.structBill.ID;
    };

    // SET Variable.Instance Struct Values
    ///////////////////////////////////////////////////////////////////////////
    private void function setVariableInstanceValues(struct structBill)
    {   
        if(structKeyExists(arguments.structBill,"ID"))
        {
          VARIABLES.Instance.structBill.ID = arguments.structBill.ID;  
        }
        if(structKeyExists(arguments.structBill,"account_id"))
        {
          VARIABLES.Instance.structBill.account_id = arguments.structBill.account_id;  
        }
        if(structKeyExists(arguments.structBill,"bill_name"))
        {
          VARIABLES.Instance.structBill.bill_name = arguments.structBill.bill_name;  
        }
        if(structKeyExists(arguments.structBill,"bill_amount"))
        {
           VARIABLES.Instance.structBill.bill_amount = arguments.structBill.bill_amount; 
        }
        if(structKeyExists(arguments.structBill,"type_id"))
        {
            VARIABLES.Instance.structBill.type_id = arguments.structBill.type_id;
        }
        if(structKeyExists(arguments.structBill,"type_name"))
        {
            VARIABLES.Instance.structBill.type_name = arguments.structBill.type_name;
        }
        if(structKeyExists(arguments.structBill,"date_added"))
        {
            VARIABLES.Instance.structBill.date_added = arguments.structBill.date_added;
        } 
    }

    // SET table row with null values
    ///////////////////////////////////////////////////////////////////////////
    private numeric function initTableRow()
    {
        sql = " INSERT INTO [dbo].[bdgBills]
                    ([account_id]
                    ,[bill_name]
                    ,[bill_amount]
                    ,[type_id]
                    ,[date_added])
                VALUES
                    (NULL
                    ,NULL
                    ,NULL
                    ,NULL
                    ,getdate())
                Select @@IDENTITY as autonum";
        qryNewBill = queryGetRow(queryExecute(sql,[],{datasource="webs"}),1);
        
        return qryNewBill.autonum;
    }
}