component displayname="bdgTypes" output="false" {
    // INIT
    ///////////////////////////////////////////////////////////////////////////
    remote struct function init(){

        VARIABLES.Instance.structType = structNew();
        VARIABLES.Instance.structType.ID = 0;
        VARIABLES.Instance.structType.type_name = "";

        return this;
    };
    // GET
    ///////////////////////////////////////////////////////////////////////////

    // Search - return all
    ///////////////////////////////////////////////////////////////////////////
    public any function get_Types()
    {
        sql =  "SELECT [ID]
                    ,[type_name]
                FROM [budget4me].[dbo].[bdgTypes]";
        qryBill = queryExecute(sql,[],{datasource="budget4me"});

        return qryBill;
    };
    remote any function getJson_Types() returnformat="json"
    {
        return get_Types();
    };
}