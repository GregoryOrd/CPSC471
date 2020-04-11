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
using CPSC471_RentalSystemAPI.Models;
using Newtonsoft.Json;

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
        // Changed from previously submitted endpoints document. Now returns string instead of boolean.
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("user/changePassword")]
        public String changePassword([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String user_id = parameters["user_id"].ToString();
            String old_password = parameters["password"].ToString();
            String new_password = parameters["new_password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(user_id), old_password, USER_TYPE.USER);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                int result = dbModel.updatePassword(user_id, new_password);
                if (result == 1)
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
        // Changed from previously submitted endpoints document. Now returns string instead of boolean.
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("propertyManager/addBuilding")]
        public String addBuilding([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String property_manager_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            String building_name = parameters["building_name"].ToString();
            String landlord_id = parameters["landlord_id"].ToString();
            String city = parameters["city"].ToString();
            String province = parameters["province"].ToString();
            String postal_code = parameters["postal_code"].ToString();
            String street_address = parameters["street_address"].ToString();
            List<Apartment> apartments = null;
            List<Amenity> amenities = null;

            JArray apartmentsArray = parameters["apartments"] as JArray;
            if(apartmentsArray != null)
            {
                apartments = apartmentsArray.Select(x => new Apartment((int)x["apartment_num"], building_name, (int)x["num_floors"])).ToList();
            }

            JArray amenitiesArray = parameters["amenities"] as JArray;
            if (amenitiesArray != null)
            {
                amenities = amenitiesArray.Select(x => new Amenity((String)x["name"], building_name, (String)x["description"], (int)x["fees"])).ToList();
            }

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(property_manager_id), password, USER_TYPE.PROPERTY_MANAGER);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                int result = dbModel.addBuilding(building_name, landlord_id, property_manager_id, city, province, postal_code, street_address, apartments, amenities);
                if(result == 1)
                {
                    return "Successfully added building: " + building_name;
                }
                return "Error adding building";
            }
        }
        #endregion

        #endregion

        #region District Manager Accessible

        #region PUT Requests
        // PUT api/districtManager/addEmployee
        // Changed from endpoints document. Now returns a string instead of a boolean and integer.
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("districtManager/addEmployee")]
        public String addEmployee([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String manager_id = parameters["manager_id"].ToString();
            String password = parameters["password"].ToString();
            String emp_FirstName = parameters["first_name"].ToString();
            String emp_LastName = parameters["last_name"].ToString();
            String emp_password = parameters["employee_password"].ToString();
            double emp_salary = (double)parameters["salary"];
            int house_number = (int)parameters["house_number"];
            String street = parameters["street"].ToString();
            String city = parameters["city"].ToString();
            String province = parameters["province"].ToString();
            String postal_code = parameters["postal_code"].ToString();
            DateTime hire_date = (DateTime)parameters["hire_date"];

            String checkInputs = "Salary: " + emp_salary + " // HouseNumber: " + house_number.ToString() + " // hire_date: " + hire_date.ToString();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(manager_id), password, USER_TYPE.DISTRICT_MANAGER);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                int result = dbModel.addEmployee(manager_id, emp_FirstName, emp_LastName, emp_password, emp_salary, house_number, street, city, province, postal_code, hire_date);
                if (result > 0)
                {
                    return "Success. New employee id: \"" + result + "\"";
                }
                else
                {
                    return "Error occured adding employee.";
                }
            }
        }
        #endregion

        #endregion

        #region Technician Accessible

        #region POST Requests
        // POST api/technician/completeRequest
        // Changed from original endpoints document. Now returns a string instead of a boolean.
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("technician/completeRequest")]
        public String completeRequest([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            String request_id = parameters["request_id"].ToString();
            String building_name = parameters["building_name"].ToString();
            String tool_id = parameters["tool_id"].ToString();
            DateTime completion_date = (DateTime)parameters["completion_date"];

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.TECHNICIAN);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                int result = dbModel.completeRequest(employee_id, request_id, building_name, tool_id, completion_date);
                if (result > 0)
                {
                    return "Successfully marked request " + request_id + " as completed.";
                }
                else
                {
                    return "Error marking request as completed.";
                }
            }
        }
        #endregion

        #endregion

        #region Landlord Accessible

        #region PUT Requests

        // PUT api/landlord/addClient
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("landlord/addClient")]
        public IActionResult addClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id          = parameters["employee_id"].ToString();
            String password             = parameters["password"].ToString();
            String first_name           = parameters["first_name"].ToString();
            String last_name            = parameters["last_name"].ToString();
            String client_password      = parameters["client_password"].ToString();
            String contract_type        = parameters["contract_type"].ToString();
            String card_number          = parameters["card_number"].ToString();
            int apartment_num           = (int) parameters["apartment_num"];
            String building_name        = parameters["building_name"].ToString();
            DateTime start_date         = (DateTime) parameters["start_date"];
            DateTime end_date           = (DateTime) parameters["end_date"];
            List<Dependent> dependents  = new List<Dependent>();
            foreach (JObject d in parameters["dependents"])
            {
                dependents.Add(new Dependent((bool) d["is_under_18"], d["first_name"].ToString(),
                    d["last_name"].ToString(), d["password"].ToString()));
            }

            JObject retVal = new JObject();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.addClient(first_name, last_name, client_password, contract_type, card_number,
                    dependents.ToArray(), apartment_num, building_name, start_date, end_date);
                retVal["user_id"] = result;
                if (result > 0)
                {
                    retVal["success"] = true;
                    return StatusCode(200, retVal);
                }
                else
                {
                    retVal["success"] = false;
                    return StatusCode(500, retVal);
                }
            }
        }

        #endregion

        #region DELETE Requests
        // No longer using the end_date parameter due to MySQL issues
        // POST api/landlord/removeClient
        [Microsoft.AspNetCore.Mvc.HttpDelete]
        [Microsoft.AspNetCore.Mvc.Route("landlord/removeClient")]
        public IActionResult removeClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String employee_id  = parameters["employee_id"].ToString();
            String password     = parameters["password"].ToString();
            String client_id    = parameters["client_id"].ToString();

            JObject retVal = new JObject();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.removeClient(client_id);
                if (result > 0)
                {
                    retVal["success"] = true;
                    return StatusCode(200, retVal);
                }
                else
                {
                    retVal["success"] = false;
                    return StatusCode(500, retVal);
                }
            }
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
        // Changed from endpoints document. Now returns string instead of boolean and int.
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("client/submitRequest")]
        public String submitRequest([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String client_id = parameters["client_id"].ToString();
            String password = parameters["password"].ToString();
            String description = parameters["description"].ToString();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(client_id), password, USER_TYPE.CLIENT);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                int result = dbModel.submitRequest(client_id, description);
                if (result > 0)
                {
                    return "Successfully submitted the request. The request id is: " + result;
                }
                else
                {
                    return "Error submitting request.";
                }
            }
        }

        #endregion

        #region POST Requests
        // POST api/client/payBill
        // Changed from originaly endpoint document. No returns string insead of boolean. Also changed to no longer take
        // card_number (string) as an input parameter.
        // The context of this endpoint is that the bill, client, and credit card already exist in the database. This endpoint
        // then updates the bill with the payment type and sets the payment date to the date when this endpoint is called.
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("client/payBill")]
        public String payBill([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            String client_id = parameters["client_id"].ToString();
            String password = parameters["password"].ToString();
            String bill_id = parameters["bill_id"].ToString();
            String payment_type = parameters["payment_type"].ToString();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(client_id), password, USER_TYPE.CLIENT);
            if (authenticationResult == false)
            {
                HttpResponseException exception = new HttpResponseException(System.Net.HttpStatusCode.Unauthorized);
                String response = "Status Code: " + (int)exception.Response.StatusCode + " (" + exception.Response.ReasonPhrase.ToString() + ")";
                return response;
            }
            else
            {
                int result = dbModel.payBill(client_id, bill_id, payment_type);
                if (result > 0)
                {
                    return "Successfully paid bill " + bill_id;
                }
                else
                {
                    return "Error paying bill";
                }
            }
        }
        #endregion

        #endregion
    }
}
