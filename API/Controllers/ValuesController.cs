using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Newtonsoft.Json.Linq;
using CPSC471_RentalSystemAPI.Helpers;

namespace CPSC471_RentalSystemAPI.Controllers
{
    [Route("api/")]
    [ApiController]
    public class ValuesController : ControllerBase
    {
        //All of these methods should call Authentication.checkAuthentication() before proceeding
        #region All Users Accessible

        #region POST Requests
        // POST api/user/changePassword
        [HttpPost]
        [Route("user/changePassword")]
        public String changePassword()
        {
            return "changePassword -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Property Manager Accessible

        #region PUT Requests
        // PUT api/propertyManager/addBuilding
        [HttpPut]
        [Route("propertyManager/addBuilding")]
        public String addBuilding()
        {
            return "addBuilding -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region District Manager Accessible

        #region PUT Requests
        // PUT api/districtManager/addEmployee
        [HttpPut]
        [Route("districtManager/addEmployee")]
        public String addEmployee()
        {
            return "addEmployee -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Technician Accessible

        #region POST Requests
        // POST api/technician/completeRequest
        [HttpPost]
        [Route("technician/completeRequest")]
        public String completeRequest()
        {
            return "completeRequest -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Landlord Accessible

        #region PUT Requests

        // PUT api/landlord/addClient
        [HttpPut]
        [Route("landlord/addClient")]
        public String addClient()
        {
            return "addClient -- Not yet implemented.";
        }

        #endregion

        #region POST Requests
        //This should maybe be switched to a DELETE Request
        // POST api/landlord/removeClient
        [HttpPost]
        [Route("landlord/removeClient")]
        public String removeClient()
        {
            return "removeClient -- Not yet implemented.";
        }
        #endregion

        #region Get Requests
        // GET api/landlord/listClients
        [HttpGet]
        [Route("landlord/listClients")]
        //public DataTable listClients()
        public String listClients()
        {
            /*DatabaseModel dbModel = new DatabaseModel();
            DataTable clients = dbModel.listClients();
            return clients;*/
            return "listClients -- Needs to be improved";
        }

        // GET api/landlord/getApartment
        [HttpGet]
        [Route("landlord/getApartments")]
        public String getApartments()
        {
            return "getApartments -- Not yet implemented.";
        }

        // GET api/landlord/getBuilding
        [HttpGet]
        [Route("landlord/getBuilding")]
        public String getBuilding()
        {
            return "getBuilding -- Not yet implemented.";
        }

        // GET api/landlord/getClient
        [HttpGet]
        [Route("landlord/getClient")]
        public String getClient()
        {
            return "getClient -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Client Accessible

        #region PUT Requests

        // PUT api/landlord/submitRequest
        [HttpPut]
        [Route("client/submitRequest")]
        public String submitRequest()
        {
            return "submitRequest -- Not yet implemented.";
        }

        #endregion

        #region POST Requests
        // POST api/client/payBill
        [HttpPost]
        [Route("client/payBill")]
        public String payBill()
        {
            return "payBill -- Not yet implemented.";
        }
        #endregion

        #endregion

        #region Professor's Examples
        // GET api/ValuesController/GetValuesById?id=5
        [HttpGet]
        [Route("GetValuesById")]
        public ActionResult<IEnumerable<string>> GetValuesById(int id)
        {
            return new string[] { "value1" };
        }

        // PUT api/ValuesController/InsertEmployee
        [HttpPut]
        [Route("InsertEmployee")]
        public void InsertEmployee([FromBody] JObject emp)
        {
            string empName = (string)emp["empName"];
            string empBdate = (string)emp["empBdate"];
        }

        // PUT api/ValuesController/UpdateEmployee
        [HttpPost]
        [Route("UpdateEmployee")]
        public void UpdateEmployee([FromBody] JObject emp)
        {
            int empId = (int)emp["empId"];
            string empName = (string)emp["empName"];
            string empBdate = (string)emp["empBdate"];
        }
        #endregion
    }
}
