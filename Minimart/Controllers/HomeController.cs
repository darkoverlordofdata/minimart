using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using Minimart.Models;

namespace Minimart.Controllers
{
    public class HomeController : Controller
    {
        private MinimartEntities storeDB = new MinimartEntities();

        public HomeController()
        {

            ViewBag.Title = "Mini-Mart";
            ViewBag.MenuHome = "";
            ViewBag.MenuCatalog = "";
            ViewBag.MenuCart = "";
            ViewBag.MenuCheckout = "";

        }

        public ActionResult Index(string confirm = "")
        {
            ViewBag.MenuHome = "active";
            ViewBag.Confirmation = confirm;
            MM_GetBrand_Result brand = storeDB.MM_GetBrand(1).ElementAt(0);
            ViewBag.Confirmation = brand.name;


            return View();

        }


    }
}
