using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Models
{
    public class Apartment
    {
        public int apartment_num { get; set; }
        public String building_name { get; set; }
        public int num_floors { get; set; }

        public Apartment(int aNum, String bName, int nFloors)
        {
            apartment_num = aNum;
            building_name = bName;
            num_floors = nFloors;
        }

        /*public Apartment()
        {
            apartment_num = -1;
            building_name = "";
            num_floors = -1;
        }

        public static implicit operator Apartment(JToken jApartment)
        {
            Apartment toReturn = new Apartment();
            toReturn.apartment_num = (int)jApartment["apartment_num"];
            toReturn.building_name = (String)jApartment["building_name"];
            toReturn.num_floors = (int)jApartment["num_floors"];
            return toReturn;
        }*/
    }
}
