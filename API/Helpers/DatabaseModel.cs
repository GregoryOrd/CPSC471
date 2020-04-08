using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using MySql.Data.MySqlClient;
using System.Linq;
using System.Threading.Tasks;
using System.Configuration;
using System.Data;
using System.Web;

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
