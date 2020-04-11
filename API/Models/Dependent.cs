using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace CPSC471_RentalSystemAPI.Models
{
    public class Dependent
    {

        public int user_id { get; set; }
        public int client_dependee { get; set; }
        public bool is_under_18 { get; set; }
        public String first_name { get; set; }
        public String last_name { get; set; }
        public string password_hash { get; set; }

        public Dependent(bool is_under_18, String first_name, String last_name, String password_hash)
        {
            this.user_id = -1;
            this.client_dependee = -1;
            this.is_under_18 = is_under_18;
            this.first_name = first_name;
            this.last_name = last_name;
            this.password_hash = password_hash;
        }

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
