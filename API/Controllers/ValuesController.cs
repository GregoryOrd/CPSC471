using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using CPSC471_RentalSystemAPI.Helpers;
using System.Web.Http;
using MySql.Data.MySqlClient;

namespace CPSC471_RentalSystemAPI.Controllers
{
    [Microsoft.AspNetCore.Mvc.Route("api/")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        private DatabaseModel dbModel = new DatabaseModel();

        //All of these methods should call Authentication.checkAuthentication() before proceeding
        #region All Users Accessible

        #region POST Requests
        // POST api/user/changePassword
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("user/changePassword")]
        public String changePassword([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String user_id = parameters["user_id"].ToString();
            String old_password = parameters["password"].ToString();
            String new_password = parameters["new_password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(user_id), old_password, USER_TYPE.USER);
            if(authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                MySqlParameter[] Parameters = new MySqlParameter[3];
                Parameters[0] = new MySqlParameter("@u_ID", user_id);
                Parameters[1] = new MySqlParameter("@p_hash", Authentication.calculatePasswordHash(new_password));
                Parameters[2] = new MySqlParameter("@result", 0);
                Parameters[2].Direction = ParameterDirection.Output;
                int result = dbModel.Execute_Non_Query_Store_Procedure("updatePassword", Parameters);
                if(result == 1)
                {
                    return "Password successfully changed to: \"" + new_password + "\"";
                }
                else
                {
                    return "Error occured changing password.";
                }
            }         
        }
        #endregion

        #endregion

        #region Property Manager Accessible

        #region PUT Requests
        // PUT api/propertyManager/addBuilding
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("propertyManager/addBuilding")]
        public String addBuilding([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.PROPERTY_MANAGER);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "addBuilding -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region District Manager Accessible

        #region PUT Requests
        // PUT api/districtManager/addEmployee
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("districtManager/addEmployee")]
        public String addEmployee([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String manager_id = parameters["manager_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(manager_id), password, USER_TYPE.DISTRICT_MANAGER);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "addEmployee -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Technician Accessible

        #region POST Requests
        // POST api/technician/completeRequest
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("technician/completeRequest")]
        public String completeRequest([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.TECHNICIAN);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "completeRequest -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Landlord Accessible

        #region PUT Requests

        // PUT api/landlord/addClient
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("landlord/addClient")]
        public String addClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "addClient -- Not yet implemented.";
        }

        #endregion

        #region POST Requests
        //This should maybe be switched to a DELETE Request
        // POST api/landlord/removeClient
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("landlord/removeClient")]
        public String removeClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "removeClient -- Not yet implemented.";
        }
        #endregion

        #region Get Requests
        // GET api/landlord/listClients
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/listClients")]
        //public DataTable listClients()
        public String listClients([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            /*DatabaseModel dbModel = new DatabaseModel();
            DataTable clients = dbModel.listClients();
            return clients;*/
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "listClients -- Needs to be improved";
        }

        // GET api/landlord/getApartment
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/getApartment")]
        public String getApartment([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "getApartment -- Not yet implemented.";
        }

        // GET api/landlord/getBuilding
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/getBuilding")]
        public String getBuilding([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "getBuilding -- Not yet implemented.";
        }

        // GET api/landlord/getClient
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/getClient")]
        public String getClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "getClient -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Client Accessible

        #region PUT Requests

        // PUT api/client/submitRequest
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("client/submitRequest")]
        public String submitRequest([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String client_id = parameters["client_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(client_id), password, USER_TYPE.CLIENT);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "submitRequest -- Not yet implemented.";
        }

        #endregion

        #region POST Requests
        // POST api/client/payBill
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("client/payBill")]
        public String payBill([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String client_id = parameters["client_id"].ToString();
            String password = parameters["password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(client_id), password, USER_TYPE.CLIENT);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            return "payBill -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Professor's Examples
        // GET api/ValuesController/GetValuesById?id=5
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("GetValuesById")]
        public ActionResult<IEnumerable<string>> GetValuesById(int id)
        {
            return new string[] { "value1" };
        }

        // PUT api/ValuesController/InsertEmployee
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("InsertEmployee")]
        public void InsertEmployee([Microsoft.AspNetCore.Mvc.FromBodyAttribute] JObject emp)
        {
            string empName = (string)emp["empName"];
            string empBdate = (string)emp["empBdate"];
        }

        // PUT api/ValuesController/UpdateEmployee
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("UpdateEmployee")]
        public void UpdateEmployee([Microsoft.AspNetCore.Mvc.FromBodyAttribute] JObject emp)
        {
            int empId = (int)emp["empId"];
            string empName = (string)emp["empName"];
            string empBdate = (string)emp["empBdate"];
        }
        #endregion
    }
}
