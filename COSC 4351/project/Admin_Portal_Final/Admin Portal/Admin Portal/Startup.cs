using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Builder;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.AspNetCore.Hosting;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Admin_Portal.Data;
using Admin_Portal.Models;
using Admin_Portal.Services;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

namespace Admin_Portal
{
    public class Startup
    {
        public Startup(IConfiguration configuration)
        {
            Configuration = configuration;
        }

        public IConfiguration Configuration { get; }

        // This method gets called by the runtime. Use this method to add services to the container.
        public void ConfigureServices(IServiceCollection services)
        {
            services.AddDbContext<ApplicationDbContext>(options =>
                options.UseSqlServer(Configuration.GetConnectionString("DefaultConnection")));

            services.AddIdentity<ApplicationUser, IdentityRole>()
                .AddEntityFrameworkStores<ApplicationDbContext>()
                .AddDefaultTokenProviders();

            // Add application services.
            services.AddTransient<IEmailSender, EmailSender>();

            services.AddMvc();
        }

        // This method gets called by the runtime. Use this method to configure the HTTP request pipeline.
        public void Configure(IApplicationBuilder app, IHostingEnvironment env, IServiceProvider services)
        {
            if (env.IsDevelopment())
            {
                app.UseBrowserLink();
                app.UseDeveloperExceptionPage();
                app.UseDatabaseErrorPage();
            }
            else
            {
                app.UseExceptionHandler("/Home/Error");
            }

            app.UseStaticFiles();

            app.UseAuthentication();

            app.UseMvc(routes =>
            {
                routes.MapRoute(
                    name: "default",
                    template: "{controller=Home}/{action=About}/{id?}");
            });

            CreateRoles(services).Wait();
        }

        private async Task CreateRoles(IServiceProvider services)
        {
            //initializing custom roles   
            var RoleManager = services.GetRequiredService<RoleManager<IdentityRole>>();
            var UserManager = services.GetRequiredService<UserManager<ApplicationUser>>();

            string[] roleNames = { "Admin", "Employee", "Manager" };
            IdentityResult roleResult;

            foreach (var roleName in roleNames)
            {
                var roleExist = await RoleManager.RoleExistsAsync(roleName);
                if (!roleExist)
                {
                    //create the roles and seed them to the database: Question 1  
                    roleResult = await RoleManager.CreateAsync(new IdentityRole(roleName));
                }
            }

            ApplicationUser user = await UserManager.FindByEmailAsync("egehitchcock@gmail.com");

            if (user == null)
            {
                user = new ApplicationUser()
                {
                    EName = "Ethan Hitchcock",
                    UserName = "egehitchcock@gmail.com",
                    Email = "egehitchcock@gmail.com",
                };
                await UserManager.CreateAsync(user, "Test@123");
            }
            await UserManager.AddToRoleAsync(user, "Admin");
            await UserManager.AddToRoleAsync(user, "Manager");


            //ApplicationUser user1 = await UserManager.FindByEmailAsync("tejas@gmail.com");

            //if (user1 == null)
            //{
            //    user1 = new ApplicationUser()
            //    {
            //        EName = "Tejas Jones",
            //        UserName = "tejas@gmail.com",
            //        Email = "tejas@gmail.com",
            //    };
            //    await UserManager.CreateAsync(user1, "Test@123");
            //}
            //await UserManager.AddToRoleAsync(user1, "Employee");

            //ApplicationUser user2 = await UserManager.FindByEmailAsync("rakesh@gmail.com");

            //if (user2 == null)
            //{
            //    user2 = new ApplicationUser()
            //    {
            //        EName = "Rakesh Maheshwari",
            //        UserName = "rakesh@gmail.com",
            //        Email = "rakesh@gmail.com",
            //    };
            //    await UserManager.CreateAsync(user2, "Test@123");
            //}
            //await UserManager.AddToRoleAsync(user2, "Manager");

        }
    }
}
