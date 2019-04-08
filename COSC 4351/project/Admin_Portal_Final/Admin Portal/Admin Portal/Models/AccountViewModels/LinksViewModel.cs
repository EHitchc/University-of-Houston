using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Admin_Portal.Models.AccountViewModels
{
    public class LinksViewModel
{
        public ApplicationUser User { get; set; }

        public IEnumerable<Role> Roles { get; set; }

        public IEnumerable<Role> AvailableRoles { get; set; }
}
}
