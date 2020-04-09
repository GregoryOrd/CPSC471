using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Models
{
    public class Amenity
    {
        public String name { get; set; }
        public String building_name { get; set; }
        public String description { get; set; }
        public int fees { get; set; }

        public Amenity(String aName, String bName, String desc, int f)
        {
            name = aName;
            building_name = bName;
            description = desc;
            fees = f;
        }
    }
}
