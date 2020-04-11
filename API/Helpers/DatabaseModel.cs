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
using System.Transactions;
using Newtonsoft.Json.Linq;
using Microsoft.AspNetCore.Hosting;
using MySql.Data.MySqlClient.Memcached;
using System.Runtime.InteropServices;

namespace CPSC471_RentalSystemAPI.Helpers
{
    public class DatabaseModel
    {

        #region Query Methods


        public string Get_PuBConnectionString()
        {
            try
            {
                return "Server=localhost;Port=3306;Database=cpsc471_rental_system;Uid=root;Pwd=&_perbanana&MUlator69;";
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
                Console.WriteLine("\n\nERROR\n" + s + "\n");
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


        public int submitRequest(String client_id, String description)
        {
            MySqlParameter[] Parameters = new MySqlParameter[2];
            Parameters[0] = new MySqlParameter("@client_id", client_id);
            Parameters[1] = new MySqlParameter("@descript", description);
            int result = Execute_Non_Query_Store_Procedure("submitRequest", Parameters);
            if(result == 1)
            {
                DataTable requestIDTable = Execute_Data_Query_Store_Procedure("getRequestID", Parameters);
                int requestID = (int)requestIDTable.Rows[0][0];
                return requestID;
            }
            return result;
        }

        public int payBill(String client_id, String bill_id, String payment_type)
        {
            MySqlParameter[] Parameters = new MySqlParameter[4];
            Parameters[0] = new MySqlParameter("@client_id", client_id);
            Parameters[1] = new MySqlParameter("@bill_id", bill_id);
            Parameters[2] = new MySqlParameter("@pay_type", payment_type);
            Parameters[3] = new MySqlParameter("@pay_date", DateTime.Today);
            int result = Execute_Non_Query_Store_Procedure("payBill", Parameters);
            return result;
        }

        public int addClient(String first_name, String last_name, String password, String contract_type, String card_number,
            Dependent[] dependents, int apartment_num, String building_name, DateTime start_date, DateTime end_date)
        {
            MySqlParameter[] Parameters = new MySqlParameter[3];
            Parameters[0] = new MySqlParameter("@fName", first_name);
            Parameters[1] = new MySqlParameter("@lName", last_name);
            Parameters[2] = new MySqlParameter("@pword", password);
            int result = Execute_Non_Query_Store_Procedure("addUser", Parameters);
            if (result != 1) return -1;

            DataTable userIDTable = Execute_Data_Query_Store_Procedure("getUserID", Parameters);
            int client_id = (int)userIDTable.Rows[0][0];
            Parameters = new MySqlParameter[3];
            Parameters[0] = new MySqlParameter("@uid", client_id);
            Parameters[1] = new MySqlParameter("@regDate", start_date);
            Parameters[2] = new MySqlParameter("@contract", contract_type);
            result = Execute_Non_Query_Store_Procedure("addClient", Parameters);
            if (result != 1) return -1;

            Parameters = new MySqlParameter[5];
            Parameters[0] = new MySqlParameter("@uid", client_id);
            Parameters[1] = new MySqlParameter("@anum", apartment_num);
            Parameters[2] = new MySqlParameter("@bname", building_name);
            Parameters[3] = new MySqlParameter("@sdate", start_date);
            Parameters[4] = new MySqlParameter("@edate", end_date);
            result = Execute_Non_Query_Store_Procedure("setRents", Parameters);
            if (result != 1) return -1;

            foreach (Dependent d in dependents)
            {
                Parameters = new MySqlParameter[3];
                Parameters[0] = new MySqlParameter("@fName", d.first_name);
                Parameters[1] = new MySqlParameter("@lName", d.last_name);
                Parameters[2] = new MySqlParameter("@pword", d.password_hash);
                result = Execute_Non_Query_Store_Procedure("addUser", Parameters);
                if (result != 1) return -1;

                userIDTable = Execute_Data_Query_Store_Procedure("getUserID", Parameters);
                int  dep_id= (int) userIDTable.Rows[0][0];

                Parameters = new MySqlParameter[3];
                Parameters[0] = new MySqlParameter("@uid", dep_id);
                Parameters[1] = new MySqlParameter("@cid", client_id);
                Parameters[2] = new MySqlParameter("@u18", d.is_under_18);
                result = Execute_Non_Query_Store_Procedure("addDependant", Parameters);
                if (result != 1) return -1;
            }

            return client_id;
        }

        public int removeClient(String client_id)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@cid", client_id);
            return Execute_Non_Query_Store_Procedure("removeClient", Parameters);
        }

        public JArray listClients(String landlord_id, String[] buildings)
        {
            DataTable clients;
            if (buildings.Length == 0)
            {
                MySqlParameter[] Parameters = new MySqlParameter[1];
                Parameters[0] = new MySqlParameter("@llid", landlord_id);
                clients = Execute_Data_Query_Store_Procedure("listClients", Parameters);
            }
            else
            {
                for (int i = 0; i < buildings.Length; i++)
                {
                    buildings[i] = "'" + buildings[i] + "'";
                }
                MySqlParameter[] Parameters = new MySqlParameter[2];
                Parameters[0] = new MySqlParameter("@llid", landlord_id);
                Parameters[1] = new MySqlParameter("@bnames", String.Join(",", buildings));
                clients = Execute_Data_Query_Store_Procedure("listClientsFiltered", Parameters);
            }

            DataRowCollection rows = clients.Rows;
            JArray retVal = new JArray();
            for (int i = 0; i < rows.Count; i ++)
            {
                retVal.Add(rows[i][0]);
            }

            return retVal;
        }

        public JObject getApartment(String building_name, int apartment_num)
        {
            MySqlParameter[] Parameters = new MySqlParameter[2];
            Parameters[0] = new MySqlParameter("@bname", building_name);
            Parameters[1] = new MySqlParameter("@anum", apartment_num);
            DataTable apartment = Execute_Data_Query_Store_Procedure("getApartment", Parameters);

            if (apartment == null || apartment.Rows.Count == 0) return null;

            JObject retVal = new JObject();
            foreach (DataColumn col in apartment.Columns)
            {
                retVal[col.ColumnName] = apartment.Rows[0][col.Ordinal].ToString();
            }

            DataTable renter = Execute_Data_Query_Store_Procedure("getRenter", Parameters);
            retVal["renter_id"] = renter.Rows.Count > 0 ? renter.Rows[0][0].ToString() : null;

            DataTable rooms = Execute_Data_Query_Store_Procedure("getRooms", Parameters);
            JArray roomArr = new JArray();
            for (int i = 0; i < rooms.Rows.Count; i++)
            {
                JObject room = new JObject();
                foreach (DataColumn col in rooms.Columns)
                {
                    room[col.ColumnName] = rooms.Rows[i][col.Ordinal].ToString();
                }
                roomArr.Add(room);
            }
            retVal["rooms"] = roomArr;

            return retVal;
        }

        public JObject getBuilding(String building_name)
        {
            MySqlParameter[] Parameters = new MySqlParameter[1];
            Parameters[0] = new MySqlParameter("@bname", building_name);
            DataTable building = Execute_Data_Query_Store_Procedure("getBuilding", Parameters);

            if (building == null || building.Rows.Count == 0) return null;

            JObject retVal = new JObject();
            foreach (DataColumn col in building.Columns)
            {
                retVal[col.ColumnName] = building.Rows[0][col.Ordinal].ToString();
            }

            DataTable anums = Execute_Data_Query_Store_Procedure("getApartmentNums", Parameters);
            JArray appArr = new JArray();
            double fullApps = 0;
            for (int i = 0; i < anums.Rows.Count; i++)
            {
                JObject app = getApartment(building_name, (int) anums.Rows[i][0]);
                appArr.Add(app);
                if (app["renter_id"] != null) fullApps++;
            }
            retVal["apartments"] = appArr;
            retVal["occupancy"] = anums.Rows.Count > 0 ? 100 - (100 * fullApps / (double) anums.Rows.Count) : 0;

            DataTable amens = Execute_Data_Query_Store_Procedure("getAmenities", Parameters);
            JArray amenArr = new JArray();
            for (int i = 0; i < amens.Rows.Count; i++)
            {
                JObject amen = new JObject();
                foreach (DataColumn col in amens.Columns)
                {
                    amen[col.ColumnName] = amens.Rows[i][col.Ordinal].ToString();
                }
                amenArr.Add(amen);
            }
            retVal["amenities"] = amenArr;

            return retVal;
        }

        #endregion
    }
}
// Parameters[0] = new MySqlParameter("@", );
