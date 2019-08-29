
component displayname="bdgAccounts" output="false" {
    // INIT
    ///////////////////////////////////////////////////////////////////////////
    remote struct function init(){

        VARIABLES.Instance.structAccount = structNew();
        VARIABLES.Instance.structAccount.ID = 0;
        VARIABLES.Instance.structAccount.account_name = "";
        VARIABLES.Instance.structAccount.account_num = "";
        VARIABLES.Instance.structAccount.account_amount = "";
        VARIABLES.Instance.structAccount.account_alias = "";
        VARIABLES.Instance.structAccount.account_date_added = "";

        return this;
    };

    // GETTERS
    ///////////////////////////////////////////////////////////////////////////

    // Search - return all
    ///////////////////////////////////////////////////////////////////////////
    remote any function getJson_Accounts() returnformat="json"
    {
        return serializeJSON(get_Accounts());
    };
    public any function get_Accounts()
    {
        sql =  "SELECT [ID]
                    ,[account_name]
                    ,[account_num]
                    ,[account_amount]
                    ,[account_alias]
                    ,[account_date_added]
                FROM [budget4me].[dbo].[bdgAccounts]";
        qryAccount = queryExecute(sql,[],{datasource="budget4me"});

        return qryAccount;
    };  

    // Search by ID (ID)
    ///////////////////////////////////////////////////////////////////////////
    remote string function getJson_AccountById(ID = 0) returnformat="json"
    {
        get_AccountById(ID = arguments.ID);
        return serializeJSON(VARIABLES.Instance.structAccount);
    };
    public struct function get_AccountById(ID = 0)
    {
        sql =  "SELECT   
                     ID
                    ,account_name
                    ,account_num
                    ,account_amount
                    ,account_alias
                    ,account_date_added
                FROM bdgAccounts
                WHERE ID = #arguments.ID#";
        qryAccount = queryExecute(sql,[],{datasource="budget4me"});

        if(qryAccount.recordcount)
        {
            setVariableInstanceValues(queryGetRow(qryAccount,1));
        }
        return VARIABLES.Instance.structAccount;
    };
    
    // Search by account name (account_name)
    ///////////////////////////////////////////////////////////////////////////
    public struct function get_AccountByAccountName(account_name = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_name]
                    ,[account_num]
                    ,[account_amount]
                    ,[account_alias]
                    ,[account_date_added]
                FROM [budget4me].[dbo].[bdgAccounts]
                WHERE account_name = :account_name";
        qryAccount = queryExecute(sql,{account_name=arguments.account_name},{datasource="budget4me"});

        if(qryAccount.recordcount)
        {
            structAccount = queryGetRow(qryAccount,1);
            setVariableInstanceValues(structAccount);
        }

        return VARIABLES.Instance.structAccount;
    };
    remote struct function getJson_AccountByAccountName(account_name = 0) returnformat="json"
    {
        get_AccountByAccountName(account_name = arguments.account_name);

        return VARIABLES.Instance.structAccount;
    };

    // Search by account num (account_num)
    ///////////////////////////////////////////////////////////////////////////
    public struct function get_AccountByAccountNumber(account_num = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_name]
                    ,[account_num]
                    ,[account_amount]
                    ,[account_alias]
                    ,[account_date_added]
                FROM [budget4me].[dbo].[bdgAccounts]
                WHERE account_num = :account_num";
        qryAccount = queryExecute(sql,{account_num=arguments.account_num},{datasource="budget4me"});

        if(qryAccount.recordcount)
        {
            structAccount = queryGetRow(qryAccount,1);
            setVariableInstanceValues(structAccount);
        }

        return VARIABLES.Instance.structAccount;
    };
    remote struct function getJson_AccountByAccountNumber(account_num = 0) returnformat="json"
    {
        get_AccountByAccountNumber(account_num = arguments.account_num);

        return VARIABLES.Instance.structAccount;
    };

    // Search by amount (account_amount)
    ///////////////////////////////////////////////////////////////////////////
    public struct function get_AccountByAmount(account_amount = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_name]
                    ,[account_num]
                    ,[account_amount]
                    ,[account_alias]
                    ,[account_date_added]
                FROM [budget4me].[dbo].[bdgAccounts]
                WHERE account_amount = :account_amount";
        qryAccount = queryExecute(sql,{account_amount=arguments.account_amount},{datasource="budget4me"});

        if(qryAccount.recordcount)
        {
            structAccount = queryGetRow(qryAccount,1);
            setVariableInstanceValues(structAccount);
        }

        return VARIABLES.Instance.structAccount;
    };
    remote struct function getJson_AccountByAmount(account_amount = 0) returnformat="json"
    {
        get_AccountByAmount(account_amount = arguments.account_amount);
        return VARIABLES.Instance.structAccount;
    };

    // Search by account alias (account_alias)
    ///////////////////////////////////////////////////////////////////////////
    public struct function get_AccountByAlias(account_amount = 0)
    {
        sql =  "SELECT [ID]
                    ,[account_name]
                    ,[account_num]
                    ,[account_amount]
                    ,[account_alias]
                    ,[account_date_added]
                FROM [budget4me].[dbo].[bdgAccounts]
                WHERE account_alias = :account_alias";
        qryAccount = queryExecute(sql,{autonum=arguments.account_alias},{datasource="budget4me"});

        if(qryAccount.recordcount)
        {
            structAccount = queryGetRow(qryAccount,1);
            setVariableInstanceValues(structAccount);
        }

        return VARIABLES.Instance.structAccount;
    };
    remote struct function getJson_AccountByAlias(account_amount = 0) returnformat="json"
    {
        get_AccountByAlias(account_amount = 0);

        return VARIABLES.Instance.structAccount;
    };

    // SETTERS
    ///////////////////////////////////////////////////////////////////////////

    // Pass JSON Obj to Variable.Instance scope
    ///////////////////////////////////////////////////////////////////////////
    remote numeric function set_account()
    {   
        init();
        // convert JSON obj to CF struct
        // Then set Variable.Instance scope struct with passed values

        setVariableInstanceValues(form);
        
        // If this is new entry create a new table row for it
        if(VARIABLES.Instance.structAccount.ID == 0 
            || !structKeyExists(VARIABLES.Instance.structAccount,"ID"))
        {   
            VARIABLES.Instance.structAccount.ID = initTableRow();
        };

        // Update row with Variable.Instance scope data
        sql = " UPDATE [budget4me].[dbo].[bdgAccounts] SET account_date_added = account_date_added " ;
        if(len(VARIABLES.Instance.structAccount.account_name) != 0){ 
            sql &= ",account_name = '#VARIABLES.Instance.structAccount.account_name#'" ;
        };
        if(len(VARIABLES.Instance.structAccount.account_num) != 0){ 
            sql &= ",account_num = '#VARIABLES.Instance.structAccount.account_num#'" ;
        };
        if(len(VARIABLES.Instance.structAccount.account_amount) != 0){ 
            sql &= ",account_amount = '#VARIABLES.Instance.structAccount.account_amount#'" ;
        };
        if(len(VARIABLES.Instance.structAccount.account_alias) != 0){ 
            sql &= ",account_alias = '#VARIABLES.Instance.structAccount.account_alias#'" ; 
        };
        sql &= " WHERE ID = #VARIABLES.Instance.structAccount.ID#";

        queryExecute(sql,[],{datasource="budget4me"});

        return VARIABLES.Instance.structAccount.ID;
    };

    // SET Variable.Instance Struct Values
    ///////////////////////////////////////////////////////////////////////////
    private void function setVariableInstanceValues(struct structAccount)
    {   
        if(structKeyExists(arguments.structAccount,"ID"))
        {
          VARIABLES.Instance.structAccount.ID = arguments.structAccount.ID;  
        }
        if(structKeyExists(arguments.structAccount,"account_name"))
        {
           VARIABLES.Instance.structAccount.account_name = arguments.structAccount.account_name; 
        }
        if(structKeyExists(arguments.structAccount,"account_num"))
        {
          VARIABLES.Instance.structAccount.account_num = arguments.structAccount.account_num;  
        }
        if(structKeyExists(arguments.structAccount,"account_amount"))
        {
           VARIABLES.Instance.structAccount.account_amount = arguments.structAccount.account_amount; 
        }
        if(structKeyExists(arguments.structAccount,"account_alias"))
        {
            VARIABLES.Instance.structAccount.account_alias = arguments.structAccount.account_alias;
        }
    }

    // DELETE Account by id
    //////////////////////////////////////////////////////////////////////
    remote void function deleteAccountById(id = 0) {
        sql = "DELETE FROM [dbo].[bdgAccounts] WHERE ID = #id#";
        qryDeleteAccount = queryExecute(sql,[],{datasource="budget4me"});
    }

    // SET table row with null values
    ///////////////////////////////////////////////////////////////////////////
    private numeric function initTableRow()
    {
        sql = " INSERT INTO [dbo].[bdgAccounts]
                    ([account_name]
                    ,[account_num]
                    ,[account_amount]
                    ,[account_alias]
                    ,[account_date_added])
                VALUES
                    (NULL
                    ,NULL
                    ,NULL
                    ,NULL
                    ,getdate())
                Select @@IDENTITY as autonum";
        qryNewAccount = queryGetRow(queryExecute(sql,[],{datasource="budget4me"}),1);
        
        return qryNewAccount.autonum;
    }
}