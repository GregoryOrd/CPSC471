using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Helpers
{
    //Enum containing values for the five types of users that interact with the system.
    //Each user type has specific priveledges (endpoints that they are allowed to use)
    //All the umbrella for all user type is USER
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
        //Function to check if a user has provided the right id and password to access privledges of a certain user type.
        public static Boolean checkAuthentication(int userID, String password, USER_TYPE userType)
        {
            //Database model object to interact with the MySQL database.
            DatabaseModel dbModel = new DatabaseModel();

            //Calculate the password hash from the inputted password
            String calculatedHash = calculatePasswordHash(password);
            
            //Create MySQLParameters for the user id and password hash
            MySqlParameter[] Parameters = new MySqlParameter[2];
            Parameters[0] = new MySqlParameter("@u_ID", userID);
            Parameters[1] = new MySqlParameter("@p_hash", calculatedHash);

            //Surrounded by a try block. Exceptions will be thrown in the case of failed authentication.
            try
            {
                //Execute a different stored procedure, based on the user type
                //This allows for querying different tables of the DB based on the user type.
                //If the stored procedure returns one row, the user passes authentication.
                //If zero rows or more than one row are returned by the stored procedure, the user fails authentication
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
                //If an exception is thrown, authentication fails
                return false;
            }
            //If there is no exception thrown, but the user is still not found in the correct table, authentication fails.
            return false;
        }

        //This function takes a password and calculates the hash for that password.
        //Currently, the hash is the same as the password. In a real world implementation, this
        //would be changed to use a proper hash function for better password security.
        public static String calculatePasswordHash(String password)
        {
            return password;
        }
    }
}
