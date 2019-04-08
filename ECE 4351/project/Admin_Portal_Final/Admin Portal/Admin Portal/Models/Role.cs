using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace Admin_Portal.Models
{
    public class Role
    {
        public int Id { get; set; }             // Id to reference a specific link

        [Required]
        [StringLength(255)]
        public string Description { get; set; }    // Short Description like "Create File"

        [Required]
        public string Link { get; set; }           // Corresponding Link for Description

        [Display(Name = "Global Link")]
        [Required]
        public bool IsGlobal { get; set; }      // Is this a Global Link
    }
}
