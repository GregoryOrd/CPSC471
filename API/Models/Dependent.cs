using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Models
{
    public class Dependent
    {
        //
        // Parameters
        //

        public int user_id { get; set; }
        public int client_dependee { get; set; }
        public bool is_under_18 { get; set; }
        public String first_name { get; set; }
        public String last_name { get; set; }
        public string password_hash { get; set; }

        //
        // Constructors
        //

        /// <summary>
        /// Creates a partially completed dependant object.
        /// This is because the request coming in doesn't have 100% of the required information.
        /// </summary>
        /// <param name="is_under_18">True if the dependant is uner 18 years old.</param>
        /// <param name="first_name">The first name of the dependant.</param>
        /// <param name="last_name">The last name of the dependant.</param>
        /// <param name="password_hash">The password hash of the dependant.</param>
        public Dependent(bool is_under_18, String first_name, String last_name, String password_hash)
        {
            this.user_id = -1;
            this.client_dependee = -1;
            this.is_under_18 = is_under_18;
            this.first_name = first_name;
            this.last_name = last_name;
            this.password_hash = password_hash;
        }

        /// <summary>
        /// Creates a dependant object.
        /// </summary>
        /// <param name="user_id">The dependant's userID.</param>
        /// <param name="client_dependee">The ID of their dependee client.</param>
        /// <param name="is_under_18">True if the dependant is uner 18 years old.</param>
        /// <param name="first_name">The first name of the dependant.</param>
        /// <param name="last_name">The last name of the dependant.</param>
        /// <param name="password_hash">The password hash of the dependant.</param>
        public Dependent(int user_id, int client_dependee, bool is_under_18,
            String first_name, String last_name, String password_hash)
        {
            this.user_id = user_id;
            this.client_dependee = client_dependee;
            this.is_under_18 = is_under_18;
            this.first_name = first_name;
            this.last_name = last_name;
            this.password_hash = password_hash;
        }

    }
}
