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

    public class ShoppingController : Controller
    {
        private MinimartEntities storeDB = new MinimartEntities();

        public ShoppingController()
        {

            ViewBag.Title = "Mini-Mart";
            ViewBag.MenuHome = "";
            ViewBag.MenuCatalog = "";
            ViewBag.MenuCart = "";
            ViewBag.MenuCheckout = "";

        }

        //
        // GET: /Shopping/

        public ActionResult Index()
        {
            ViewBag.MenuCart = "active";
            int cid = 0;

            if (Request.Cookies["cart_id"] != null)
            {
                cid = Convert.ToInt32(Request.Cookies["cart_id"].Value);
            }
            return View(storeDB.MM_GetCart(cid).ToList());
        }

        //
        // GET: /Shopping/Checkout

        public ActionResult Checkout()
        {
            ViewBag.MenuCheckout = "active";
            return View();
        }

        //
        // POST: /Confirmation/
        [HttpPost]
        public void Confirmation(string name, string email, string phone, string ship_to, string address1, string address2, string city, string country, string state, string zip)
        {

            int cid = 0;
            string guid = Guid.NewGuid().ToString();

            if (Request.Cookies["cart_id"] != null)
            {
                cid = Convert.ToInt32(Request.Cookies["cart_id"].Value);
                storeDB.MM_ShipTo(cid, guid, name, email, phone, ship_to, address1, address2, city, country, state, zip);
                Response.Cookies.Remove("cart_id");
                Response.Redirect("/?confirm=" + guid);
            }
            else 
            {
                Response.Redirect("/");
            }
        }

    }

}
