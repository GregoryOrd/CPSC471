using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Models
{
    public class Amenity
    {
        //
        // Parameters
        //

        public String name { get; set; }
        public String building_name { get; set; }
        public String description { get; set; }
        public int fees { get; set; }

        //
        // Constructors
        //

        /// <summary>
        /// Creates an amenity object.
        /// </summary>
        /// <param name="aName">The name of the amenity.</param>
        /// <param name="bName">The name of the building the amenity belongs to.</param>
        /// <param name="desc">A description of the amenity.</param>
        /// <param name="f">The fee associated with the amenity.</param>
        public Amenity(String aName, String bName, String desc, int f)
        {
            name = aName;
            building_name = bName;
            description = desc;
            fees = f;
        }
    }
}
