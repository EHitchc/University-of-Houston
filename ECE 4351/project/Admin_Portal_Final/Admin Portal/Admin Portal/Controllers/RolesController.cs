using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;
using Admin_Portal.Data;
using Admin_Portal.Models;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Identity;
using Admin_Portal.Services;

namespace Admin_Portal.Controllers
{
    [Authorize]
    public class RolesController : Controller
    {
        private readonly ApplicationDbContext _role;
        private readonly UserManager<ApplicationUser> _userManager;
        private readonly RoleManager<IdentityRole> _roleManager;

        public RolesController(
            ApplicationDbContext role,
            UserManager<ApplicationUser> userManager,
            RoleManager<IdentityRole> roleManager)
        {
            _role = role;
            _userManager = userManager;
            _roleManager = roleManager;
        }


        // GET: Roles
        public async Task<IActionResult> Index()
        {
            List<Role> model = new List<Role>();
            var RolesList = await _role.Role.OrderBy(r => r.Description).ToListAsync();
    
            if (!User.IsInRole("Admin") && !User.IsInRole("Manager"))
            {
                var permittedRoles = await _userManager.GetRolesAsync(await _userManager.GetUserAsync(User));
                foreach (var role in RolesList)
                {
                    if (permittedRoles.Contains(role.Description) || role.IsGlobal)
                    {  
                        model.Add(role);
                    }
                }
            }
            else
            {
                model = RolesList;
            }

            return View(model);
        }

        // GET: Roles/Details/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var role = await _role.Role
                .SingleOrDefaultAsync(m => m.Id == id);
            if (role == null)
            {
                return NotFound();
            }

            return View(role);
        }


        // GET: Roles/Create
        [Authorize(Roles = "Admin,Manager")]
        public IActionResult Create()
        {
            return View();
        }

        // POST: Roles/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin,Manager")]
        public async Task<IActionResult> Create([Bind("Id,Description,Link,IsGlobal")] Models.Role role)
        {
            IdentityResult roleResult;
            IdentityRole identityRole;

            if (ModelState.IsValid)
            {
                var roleExist = await _roleManager.RoleExistsAsync(role.Description);
                if (!roleExist)
                {
                    roleResult = await _roleManager.CreateAsync(new IdentityRole(role.Description));
                    identityRole = await _roleManager.FindByNameAsync(role.Description);
                }
                else
                {
                    identityRole = await _roleManager.FindByNameAsync(role.Description);
                }

                _role.Add(role);
                await _role.SaveChangesAsync();
                await _roleManager.UpdateAsync(identityRole);
                return RedirectToAction(nameof(Index));
            }
            return View(role);
        }

        // GET: Roles/Edit/5
        [Authorize(Roles = "Admin,Manager")]
        public async Task<IActionResult> Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var role = await _role.Role.SingleOrDefaultAsync(m => m.Id == id);
            if (role == null)
            {
                return NotFound();
            }
            return View(role);
        }

        // POST: Roles/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see http://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin,Manager")]
        public async Task<IActionResult> Edit(int id, [Bind("Id,Description,Link,IsGlobal")] Models.Role role)
        {
            if (id != role.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _role.Update(role);
                    var OldRole = _role.Role.AsNoTracking().ToList().Find(m => m.Id == id);
                    var IRole = await _roleManager.FindByNameAsync(OldRole.Description);
                    IRole.Name = role.Description;
                    await _roleManager.UpdateAsync(IRole);
                    await _role.SaveChangesAsync();
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!RoleExists(role.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }
            return View(role);
        }

        // GET: Roles/Delete/5
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var role = await _role.Role
                .SingleOrDefaultAsync(m => m.Id == id);
            if (role == null)
            {
                return NotFound();
            }

            return View(role);
        }

        // POST: Roles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        [Authorize(Roles = "Admin")]
        public async Task<IActionResult> DeleteConfirmed(int id)
        {
            var role = await _role.Role.SingleOrDefaultAsync(m => m.Id == id);

            IdentityResult roleResult;
            IdentityRole identityRole;

            var roleExist = await _roleManager.RoleExistsAsync(role.Description);
            if (roleExist)
            {
                identityRole = await _roleManager.FindByNameAsync(role.Description);
                roleResult = await _roleManager.DeleteAsync(identityRole);
            }
            else
            {
                identityRole = await _roleManager.FindByNameAsync(role.Description);
            }

            _role.Remove(role);
            await _role.SaveChangesAsync();
            await _roleManager.UpdateAsync(identityRole);
            return RedirectToAction(nameof(Index));
        }

        private bool RoleExists(int id)
        {
            return _role.Role.Any(e => e.Id == id);
        }

    }
}
