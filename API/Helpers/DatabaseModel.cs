using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Web;
using CPSC471_RentalSystemAPI.Models;

namespace CPSC471_RentalSystemAPI.Helpers
{
    public class DatabaseModel
    {

        #region Query Methods


        public string Get_PuBConnectionString()
        {
            try
            {
                return "Server=localhost;Port=3306;Database=cpsc471_rental_system;Uid=root;Pwd=;";
            }
            catch { return null; }
        }

        public MySqlConnection GetMySQLConnection()
        {
            if (Get_PuBConnectionString() == null)
                return null;
            return new MySqlConnection(Get_PuBConnectionString());
        }

        /// <summary>
        /// This method is responisble to to execute a query in your RDBMS and return for you an output value. 
        /// For instance, in some cases when you insert a new records you need to return the id of that record to do other actions
        /// </summary>
        /// <returns></returns>

        public int Execute_Non_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters, string returnValue)
        {
            if (GetMySQLConnection() == null)
                return -2;

            int successfulQuery = -2;
            MySqlCommand mySqlCommand = new MySqlCommand(procedureName, GetMySQLConnection());
            mySqlCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                mySqlCommand.Parameters.AddRange(parameters);
                mySqlCommand.Connection.Open();
                successfulQuery = mySqlCommand.ExecuteNonQuery();
                successfulQuery = (int)mySqlCommand.Parameters["@" + returnValue].Value;

            }
            catch (Exception ex)
            {
                string s = ex.Message;
            }

            if (mySqlCommand.Connection != null && mySqlCommand.Connection.State == ConnectionState.Open)
                mySqlCommand.Connection.Close();

            return successfulQuery;
        }


        /// <summary>
        /// This method is responisble to to execute a query in your RDBMS and return for you if it was successult executed. Mainly used for insert,update, and delete
        /// </summary>
        /// <returns></returns>
        public int Execute_Non_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            if (GetMySQLConnection() == null)
                return -1;

            int successfulQuery = 1;
            MySqlCommand mySqlCommand = new MySqlCommand(procedureName, GetMySQLConnection());
            mySqlCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                mySqlCommand.Parameters.AddRange(parameters);
                mySqlCommand.Connection.Open();
                successfulQuery = mySqlCommand.ExecuteNonQuery();
                // successfulQuery =1

            }
            catch (Exception ex)
            {
                string s = ex.Message;
                successfulQuery = -2;
            }

            if (mySqlCommand.Connection != null && mySqlCommand.Connection.State == ConnectionState.Open)
                mySqlCommand.Connection.Close();

            return successfulQuery;
        }


        /// <summary>
        /// This method is responisble to to execute to rertieve data from your RDBSM by executing a stored procedure. Mainly used when using one select statment
        /// </summary>
        /// <returns></returns>
        public DataTable Execute_Data_Query_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            if (GetMySQLConnection() == null)
                return null;

            DataTable dataTable = new DataTable();
            MySqlDataAdapter mySqlAdapter = new MySqlDataAdapter(procedureName, GetMySQLConnection());
            mySqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                mySqlAdapter.SelectCommand.Parameters.AddRange(parameters);
                mySqlAdapter.SelectCommand.Connection.Open();
                mySqlAdapter.Fill(dataTable);
            }
            catch (Exception er)
            {
                string ee = er.ToString();
                dataTable = null;
            }

            if (mySqlAdapter.SelectCommand.Connection != null && mySqlAdapter.SelectCommand.Connection.State == ConnectionState.Open)
                mySqlAdapter.SelectCommand.Connection.Close();

            return dataTable;
        }

        /// <summary>
        /// This method is responisble to to execute to rertieve data from your RDBSM by executing a stored procedure. Mainly used when more than one table is being returned.
        /// </summary>
        /// <returns></returns>
        /// 

        public DataSet Execute_Data_Dataset_Store_Procedure(string procedureName, MySqlParameter[] parameters)
        {
            if (GetMySQLConnection() == null)
                return null;

            DataSet dataset = new DataSet();
            MySqlDataAdapter mySqlAdapter = new MySqlDataAdapter(procedureName, GetMySQLConnection());
            mySqlAdapter.SelectCommand.CommandType = CommandType.StoredProcedure;

            try
            {
                mySqlAdapter.SelectCommand.Parameters.AddRange(parameters);
                mySqlAdapter.SelectCommand.Connection.Open();
                mySqlAdapter.Fill(dataset);
            }
            catch (Exception er)
            {
                string ee = er.ToString();
                dataset = null;
            }

            if (mySqlAdapter.SelectCommand.Connection != null && mySqlAdapter.SelectCommand.Connection.State == ConnectionState.Open)
                mySqlAdapter.SelectCommand.Connection.Close();

            return dataset;
        }

        /// <summary>
        /// This method check if the connection string is valid or not
        /// </summary>
        /// <returns></returns>

        public bool CheckDatabaseConnectionString(string ConnectionString)
        {
            try
            {

                MySqlConnection con = new MySqlConnection(ConnectionString);
                con.Open();
                con.Close();
                return true;
            }
            catch
            {
                return false;
            }


        }
        #endregion


        #region Execute Queries

        public DataTable listClients()
        {
            MySqlParameter[] Parameters = new MySqlParameter[0];
            return Execute_Data_Query_Store_Procedure("listClients", Parameters);
        }

        public int updatePassword(String user_id, String new_password)
        {
            MySqlParameter[] Parameters = new MySqlParameter[3];
            Parameters[0] = new MySqlParameter("@u_ID", user_id);
            Parameters[1] = new MySqlParameter("@p_hash", Authentication.calculatePasswordHash(new_password));
            Parameters[2] = new MySqlParameter("@result", 0);
            Parameters[2].Direction = ParameterDirection.Output;
            return Execute_Non_Query_Store_Procedure("updatePassword", Parameters);
        }

        public int addBuilding(String building_name, String landlord_id, String property_manager_id, String city, String province, String postal_code, String street_address, List<Apartment> apartments, List<Amenity> amenities)
        {
            List<int> results = new List<int>();

            //Add building
            MySqlParameter[] Parameters = new MySqlParameter[8];
            Parameters[0] = new MySqlParameter("@bName", building_name);
            Parameters[1] = new MySqlParameter("@land_id", landlord_id);
            Parameters[2] = new MySqlParameter("@prop_id", property_manager_id);
            Parameters[3] = new MySqlParameter("@city", city);
            Parameters[4] = new MySqlParameter("@prov", province);
            Parameters[5] = new MySqlParameter("@postal", postal_code);
            Parameters[6] = new MySqlParameter("@street", street_address);
            Parameters[7] = new MySqlParameter("@result", 0);
            Parameters[7].Direction = ParameterDirection.Output;
            results.Add(Execute_Non_Query_Store_Procedure("addBuilding", Parameters));

            //Add apartments to the building
            for(int i = 0; i < apartments.Count(); i++)
            {
                Parameters = new MySqlParameter[4];
                Parameters[0] = new MySqlParameter("@bName", building_name);
                Parameters[1] = new MySqlParameter("@aNum", apartments[i].apartment_num);
                Parameters[2] = new MySqlParameter("@nFloors", apartments[i].num_floors);
                Parameters[3] = new MySqlParameter("@result", 0);
                Parameters[3].Direction = ParameterDirection.Output;
                results.Add(Execute_Non_Query_Store_Procedure("addApartment", Parameters));
            }

            //Add amenities to the building
            for (int i = 0; i < amenities.Count(); i++)
            {
                Parameters = new MySqlParameter[5];
                Parameters[0] = new MySqlParameter("@bName", building_name);
                Parameters[1] = new MySqlParameter("@aName", amenities[i].name);
                Parameters[2] = new MySqlParameter("@descrp", amenities[i].description);
                Parameters[3] = new MySqlParameter("@f", amenities[i].fees);
                Parameters[4] = new MySqlParameter("@result", 0);
                Parameters[4].Direction = ParameterDirection.Output;
                results.Add(Execute_Non_Query_Store_Procedure("addAmenity", Parameters));
            }

            if (results.Contains(0)) { return 0; }
            return 1;
        }

        //District Manager adds an Employee
        public int addEmployee(String manager_id, String emp_FirstName, String emp_LastName, String emp_password, double emp_salary, int house_number, String street, String city, String province, String postal_code, DateTime hire_date)
        {
            //Add building
            MySqlParameter[] Parameters = new MySqlParameter[3];
            Parameters[0] = new MySqlParameter("@fName", emp_FirstName);
            Parameters[1] = new MySqlParameter("@lName", emp_LastName);
            Parameters[2] = new MySqlParameter("@pword", emp_password);
            int result = Execute_Non_Query_Store_Procedure("addUser", Parameters);
            if(result == 1)
            {
                DataTable userIDTable = Execute_Data_Query_Store_Procedure("getUserID", Parameters);
                int newUserID = (int)userIDTable.Rows[0][0];
                Parameters = new MySqlParameter[9];
                Parameters[0] = new MySqlParameter("@userID", newUserID);
                Parameters[1] = new MySqlParameter("@man_id", manager_id);
                Parameters[2] = new MySqlParameter("@hire_date", hire_date);
                Parameters[3] = new MySqlParameter("@salary", emp_salary);
                Parameters[4] = new MySqlParameter("@house_num", house_number);
                Parameters[5] = new MySqlParameter("@street", street);
                Parameters[6] = new MySqlParameter("@city", city);
                Parameters[7] = new MySqlParameter("@province", province);
                Parameters[8] = new MySqlParameter("@postal", postal_code);

                result = Execute_Non_Query_Store_Procedure("addEmployee", Parameters);
                if(result == 1)
                {
                    return newUserID;
                }
                else
                {
                    return -1;
                }
            }
            else
            {
                return -1;
            }
        }

        public int completeRequest(String employee_id, String request_id, String building_name, String tool_id, DateTime completion_date)
        {
            MySqlParameter[] Parameters = new MySqlParameter[5];
            Parameters[0] = new MySqlParameter("@employee_id", employee_id);
            Parameters[1] = new MySqlParameter("@request_id", request_id);
            Parameters[2] = new MySqlParameter("@building_name", building_name);
            Parameters[3] = new MySqlParameter("@tool_id", tool_id);
            Parameters[4] = new MySqlParameter("@completion_date", completion_date);
            int result = Execute_Non_Query_Store_Procedure("completeRequest", Parameters);
            return result;
        }

        #endregion

        #region Examples
        public int updateEmployee(int empId,string empName, DateTime embBDate,string empAddress)
        {


            MySqlParameter[] Parameters = new MySqlParameter[4]; // Specifc number of parametrs for this tored procedure. 
            Parameters[0] = new MySqlParameter("@empName", empName);//Make sure parameters name matches thenames given in your stored procedure
            Parameters[1] = new MySqlParameter("@embBDate", embBDate);
            Parameters[2] = new MySqlParameter("@empAddress", empAddress);
            Parameters[3] = new MySqlParameter("@empId", empId);

            return Execute_Non_Query_Store_Procedure("SP_UpdateEmpInfo", Parameters);//Make sure procedure name matches the name given in your RDBMS
        }


        public int insertEmployee( string empName, DateTime embBDate, string empAddress)
        {
            MySqlParameter[] Parameters = new MySqlParameter[3];
            Parameters[0] = new MySqlParameter("@empName", empName);
            Parameters[1] = new MySqlParameter("@embBDate", embBDate);
            Parameters[2] = new MySqlParameter("@empAddress", empAddress);

            Parameters[2] = new MySqlParameter("@empId", SqlDbType.Int);
            Parameters[2].Direction = ParameterDirection.Output;


            return Execute_Non_Query_Store_Procedure("SP_InsertEmpInfo", Parameters, "empId");
        }
        #endregion
    }
}
