using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Helpers
{
    public enum USER_TYPE
    {
        USER,
        PROPERTY_MANAGER,
        DISTRICT_MANAGER,
        TECHNICIAN,
        LANDLORD,
        CLIENT
    }

    public class Authentication
    {
        public static Boolean checkAuthentication(int userID, String password, USER_TYPE userType)
        {
            DatabaseModel dbModel = new DatabaseModel();

            String calculatedHash = calculatePasswordHash(password);
            MySqlParameter[] Parameters = new MySqlParameter[2];
            Parameters[0] = new MySqlParameter("@u_ID", userID);
            Parameters[1] = new MySqlParameter("@p_hash", calculatedHash);

            try
            {
                switch (userType)
                {
                    case USER_TYPE.USER:
                        DataTable users = dbModel.Execute_Data_Query_Store_Procedure("getUsers", Parameters);
                        if (users.Rows.Count == 1) return true;
                        break;

                    case USER_TYPE.PROPERTY_MANAGER:
                        DataTable propertyManagers = dbModel.Execute_Data_Query_Store_Procedure("getPropertyManagers", Parameters);
                        if (propertyManagers.Rows.Count == 1) return true;
                        break;

                    case USER_TYPE.DISTRICT_MANAGER:
                        DataTable districtManagers = dbModel.Execute_Data_Query_Store_Procedure("getDistrictManagers", Parameters);
                        if (districtManagers.Rows.Count == 1) return true;
                        break;

                    case USER_TYPE.TECHNICIAN:
                        DataTable technicians = dbModel.Execute_Data_Query_Store_Procedure("getTechnicians", Parameters);
                        if (technicians.Rows.Count == 1) return true;
                        break;

                    case USER_TYPE.LANDLORD:
                        DataTable landlords = dbModel.Execute_Data_Query_Store_Procedure("getLandlords", Parameters);
                        if (landlords.Rows.Count == 1) return true;
                        break;

                    case USER_TYPE.CLIENT:
                        DataTable clients = dbModel.Execute_Data_Query_Store_Procedure("getClients", Parameters);
                        if (clients.Rows.Count == 1) return true;
                        break;
                }
            }catch(Exception e)
            {
                return false;
            }
            return false;
        }

        public static String calculatePasswordHash(String password)
        {
            return password;
        }
    }
}
