using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;


namespace Minimart.Controllers
{
    public class HomeController : Controller
    {
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
            return View();

        }


    }
}
