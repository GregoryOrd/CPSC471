﻿using System;
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
        public IActionResult changePassword([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            JObject retVal = new JObject();
            String user_id = parameters["user_id"].ToString();
            String old_password = parameters["password"].ToString();
            String new_password = parameters["new_password"].ToString();
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(user_id), old_password, USER_TYPE.USER);
            if (authenticationResult == false)
            {
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.updatePassword(user_id, new_password);
                if (result == 1)
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

        #endregion

        #region Property Manager Accessible

        #region PUT Requests
        // PUT api/propertyManager/addBuilding
        // Changed from previously submitted endpoints document. Now returns string instead of boolean.
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("propertyManager/addBuilding")]
        public IActionResult addBuilding([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            JObject retVal = new JObject();
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
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.addBuilding(building_name, landlord_id, property_manager_id, city, province, postal_code, street_address, apartments, amenities);
                if(result == 1)
                {
                    retVal["success"] = true;
                    return StatusCode(200, retVal);
                }
                retVal["success"] = false;
                return StatusCode(500, retVal);
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
        public IActionResult addEmployee([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            JObject retVal = new JObject();
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
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.addEmployee(manager_id, emp_FirstName, emp_LastName, emp_password, emp_salary, house_number, street, city, province, postal_code, hire_date);
                if (result > 0)
                {
                    retVal["success"] = true;
                    retVal["user_id"] = result;
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

        #endregion

        #region Technician Accessible

        #region POST Requests
        // POST api/technician/completeRequest
        // Changed from original endpoints document. Now returns a string instead of a boolean.
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("technician/completeRequest")]
        public IActionResult completeRequest([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            JObject retVal = new JObject();
            String employee_id = parameters["employee_id"].ToString();
            String password = parameters["password"].ToString();
            String request_id = parameters["request_id"].ToString();
            String building_name = parameters["building_name"].ToString();
            String tool_id = parameters["tool_id"].ToString();
            DateTime completion_date = (DateTime)parameters["completion_date"];

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.TECHNICIAN);
            if (authenticationResult == false)
            {
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.completeRequest(employee_id, request_id, building_name, tool_id, completion_date);
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

        #endregion

        #region Landlord Accessible

        #region PUT Requests

        /// <summary>
        /// PUT api/landlord/addClient
        /// Used by a landlord to add a client to the database.
        /// </summary>
        /// <param name="parameters">The JSON body from the request</param>
        /// <returns>Success bool, and the userID of the added client.</returns>
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("landlord/addClient")]
        public IActionResult addClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            // Get parameters
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

            // Construct dependants
            List<Dependent> dependents  = new List<Dependent>();
            foreach (JObject d in parameters["dependents"])
            {
                dependents.Add(new Dependent((bool) d["is_under_18"], d["first_name"].ToString(),
                    d["last_name"].ToString(), d["password"].ToString()));
            }

            // Init a return value
            JObject retVal = new JObject();

            // Authenticate the user
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                // Unauthorized
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                // Add the client to the database
                int result = dbModel.addClient(first_name, last_name, client_password, contract_type, card_number,
                    dependents.ToArray(), apartment_num, building_name, start_date, end_date);

                // Add the new ID to the return value
                retVal["user_id"] = result;
                
                // Check for success and return the appropriate response
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
        /// <summary>
        /// POST api/landlord/removeClient
        /// Used by a landlord to remove a client from the database.
        /// No longer using the end_date parameter due to MySQL issues.
        /// </summary>
        /// <param name="parameters">The JSON body from the request</param>
        /// <returns>Success bool.</returns>
        [Microsoft.AspNetCore.Mvc.HttpDelete]
        [Microsoft.AspNetCore.Mvc.Route("landlord/removeClient")]
        public IActionResult removeClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            // Get parameters
            String employee_id  = parameters["employee_id"].ToString();
            String password     = parameters["password"].ToString();
            String client_id    = parameters["client_id"].ToString();

            // Init a return value
            JObject retVal = new JObject();

            // Authenticate the user
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                // Unauthorized
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                // remove the client from the database
                int result = dbModel.removeClient(client_id);
                
                // Check for success and return the appropriate response
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
        /// <summary>
        /// GET api/landlord/listClients
        /// Used by a landlord to list all of their clients.
        /// Now just returns client IDs.
        /// </summary>
        /// <param name="parameters">The JSON body from the request</param>
        /// <returns>Success bool, and a list of clientIDs.</returns>
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/listClients")]
        public IActionResult listClients([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            // Get parameters
            String employee_id      = parameters["employee_id"].ToString();
            String password         = parameters["password"].ToString();

            // Construct a list of filter buildings
            List<String> buildings  = new List<String>();
            if (parameters.ContainsKey("buildings"))
            {
                foreach (String b in parameters["buildings"])
                {
                    buildings.Add(b);
                }
            }

            // Init a return value
            JObject retVal = new JObject();

            // Authenticate the user
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                // Unauthorized
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                // Get the list of clientIDs
                JArray result = dbModel.listClients(employee_id, buildings.ToArray());
                
                // Check for success and return the appropriate response
                if (result != null)
                {
                    retVal["success"] = true;
                    retVal["clients"] = result;
                    return StatusCode(200, retVal);
                }
                else
                {
                    retVal["success"] = false;
                    return StatusCode(500, retVal);
                }
            }
        }

        /// <summary>
        /// GET api/landlord/getApartment
        /// Used by a landlord to get information about an apartment.
        /// </summary>
        /// <param name="parameters">The JSON body from the request</param>
        /// <returns>Success bool, and a JSON object representing the requested apartment.</returns>
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/getApartment")]
        public IActionResult getApartment([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            // Get parameters
            String employee_id      = parameters["employee_id"].ToString();
            String password         = parameters["password"].ToString();
            String building_name    = parameters["building_name"].ToString();
            int apartment_num       = (int) parameters["apartment_num"];

            // Init a return value
            JObject retVal = new JObject();

            // Authenticate the user
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                // Unauthorized
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                // Get the apartment information
                JObject result = dbModel.getApartment(building_name, apartment_num);
                
                // Check for success and return the appropriate response
                if (result != null)
                {
                    retVal["success"] = true;
                    retVal["apartment"] = result;
                    return StatusCode(200, retVal);
                }
                else
                {
                    retVal["success"] = false;
                    return StatusCode(404, retVal);
                }
            }
        }

        /// <summary>
        /// GET api/landlord/getBuilding
        /// Used by a landlord to get information about a building.
        /// </summary>
        /// <param name="parameters">The JSON body from the request</param>
        /// <returns>Success bool, and a JSON object representing the requested building,
        /// including an array of contained apartments.</returns>
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/getBuilding")]
        public IActionResult getBuilding([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            // Get parameters
            String employee_id      = parameters["employee_id"].ToString();
            String password         = parameters["password"].ToString();
            String building_name    = parameters["building_name"].ToString();

            // Init a return value
            JObject retVal = new JObject();

            // Authenticate the user
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                // Unauthorized
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                // Get the building information
                JObject result = dbModel.getBuilding(building_name);
                
                // Check for success and return the appropriate response
                if (result != null)
                {
                    retVal["success"] = true;
                    retVal["building"] = result;
                    return StatusCode(200, retVal);
                }
                else
                {
                    retVal["success"] = false;
                    return StatusCode(404, retVal);
                }
            }
        }

        /// <summary>
        /// GET api/landlord/getClient
        /// Used by a landlord to get information about a client.
        /// </summary>
        /// <param name="parameters">The JSON body from the request</param>
        /// <returns>Success bool, and a JSON object representing the requested client.</returns>
        [Microsoft.AspNetCore.Mvc.HttpGet]
        [Microsoft.AspNetCore.Mvc.Route("landlord/getClient")]
        public IActionResult getClient([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            // Get parameters
            String employee_id  = parameters["employee_id"].ToString();
            String password     = parameters["password"].ToString();
            String client_id    = parameters["client_id"].ToString();

            // Init a return value
            JObject retVal = new JObject();

            // Authenticate the user
            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(employee_id), password, USER_TYPE.LANDLORD);
            if (authenticationResult == false)
            {
                // Unauthorized
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                // Get the client information
                JObject result = dbModel.getClient(client_id);
                
                // Check for success and return the appropriate response
                if (result != null)
                {
                    retVal["success"] = true;
                    retVal["client"] = result;
                    return StatusCode(200, retVal);
                }
                else
                {
                    retVal["success"] = false;
                    return StatusCode(404, retVal);
                }
            }
        }
        #endregion

        #endregion

        #region Client Accessible

        #region PUT Requests

        // PUT api/client/submitRequest
        // Changed from endpoints document. Now returns string instead of boolean and int.
        [Microsoft.AspNetCore.Mvc.HttpPut]
        [Microsoft.AspNetCore.Mvc.Route("client/submitRequest")]
        public IActionResult submitRequest([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            JObject retVal = new JObject();
            String client_id = parameters["client_id"].ToString();
            String password = parameters["password"].ToString();
            String description = parameters["description"].ToString();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(client_id), password, USER_TYPE.CLIENT);
            if (authenticationResult == false)
            {
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.submitRequest(client_id, description);
                if (result > 0)
                {
                    retVal["success"] = true;
                    retVal["request_id"] = result;
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

        #region POST Requests
        // POST api/client/payBill
        // Changed from originaly endpoint document. No returns string insead of boolean. Also changed to no longer take
        // card_number (string) as an input parameter.
        // The context of this endpoint is that the bill, client, and credit card already exist in the database. This endpoint
        // then updates the bill with the payment type and sets the payment date to the date when this endpoint is called.
        [Microsoft.AspNetCore.Mvc.HttpPost]
        [Microsoft.AspNetCore.Mvc.Route("client/payBill")]
        public IActionResult payBill([Microsoft.AspNetCore.Mvc.FromBody] JObject parameters)
        {
            JObject retVal = new JObject();
            String client_id = parameters["client_id"].ToString();
            String password = parameters["password"].ToString();
            String bill_id = parameters["bill_id"].ToString();
            String payment_type = parameters["payment_type"].ToString();

            Boolean authenticationResult = Authentication.checkAuthentication(Int32.Parse(client_id), password, USER_TYPE.CLIENT);
            if (authenticationResult == false)
            {
                retVal["success"] = false;
                return StatusCode(401, retVal);
            }
            else
            {
                int result = dbModel.payBill(client_id, bill_id, payment_type);
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

        #endregion
    }
}
