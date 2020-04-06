using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Helpers
{

    public enum USER_TYPE
    {
        USER,
        PROPERTY_MANAGER,
        DISTRICT_MANAGER,
        TECHNICIAN,
        LANDLORD,
        CLIENT
    }

    public class Authentication
    {
        public static Boolean checkAuthentication(int userID, String password, USER_TYPE userType)
        {
            String calculatedHash = calculatePasswordHash(password);
            //Query DB using userID to find the stored hash and userType based on userID
            //If the hashes and userTypes match return true, otherwise return false.
            return true;
        }

        public static String calculatePasswordHash(String password)
        {
            return "ExampleHash";
        }
    }
}
