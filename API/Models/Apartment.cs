using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Models
{
    public class Apartment
    {
        //
        // Parameters
        //
        public int apartment_num { get; set; }
        public String building_name { get; set; }
        public int num_floors { get; set; }

        //
        // Constructors
        //

        /// <summary>
        /// Constructs a basic apartment object.
        /// </summary>
        /// <param name="aNum">The apartment number.</param>
        /// <param name="bName">The building name.</param>
        /// <param name="nFloors">The number of floors inside the apartment.</param>
        public Apartment(int aNum, String bName, int nFloors)
        {
            apartment_num = aNum;
            building_name = bName;
            num_floors = nFloors;
        }
    }
}
