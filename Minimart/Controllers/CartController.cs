using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using Minimart.Models;
using System.Data.Objects;

namespace Minimart.Controllers
{
    public class CartController : Controller
    {
        private MinimartEntities storeDB = new MinimartEntities();

        //
        // POST: /Cart/
        [HttpPost]
        public ActionResult Index()
        {
            int cid = Convert.ToInt32(Request.Cookies["cart_id"].Value);
            return Json(storeDB.MM_GetCart(cid));
        }

        //
        // POST: /Cart/Delete
        [HttpPost]
        public ActionResult Delete()
        {
            int cid = Convert.ToInt32(Request.Cookies["cart_id"].Value);
            return Json(storeDB.MM_DelCart(cid));
        }

        //
        // POST: /Cart/Update
        [HttpPost]
        public ActionResult Update(string productId, string quantity, string price)
        {

            string cart_id; // s.b. stored in a Cookie

            if (Request.Cookies["cart_id"] == null)
            {
                cart_id = NewCartID();
            }
            else
            {
                cart_id = Request.Cookies["cart_id"].Value;

                // Validate the Cookie
                ObjectResult<MM_GetOrder_Result> rs = storeDB.MM_GetOrder(Convert.ToInt32(cart_id));
                try
                {
                    if (rs.ElementAt(0).order_status != 0)
                    {
                        // Cookie points to a completed order - get a new cart
                        cart_id = NewCartID();
                    }
                }
                catch (Exception e)
                {
                    // There was some kind of error - get a new cart
                    cart_id = NewCartID();
                }
            }

            int cid = Convert.ToInt32(cart_id);
            int pid = Convert.ToInt32(productId);
            decimal val = Convert.ToDecimal(price);
            int qty = Convert.ToInt32(quantity);

            var cart = storeDB.MM_UpdateCart(cid, pid, val, qty);

            return Json(cart_id);
        }

        protected string NewCartID()
        {
            string cart_id = storeDB.MM_NewCart(GetIPAddress()).First().ToString();
            Response.Cookies.Remove("cart_id");
            HttpCookie cookie = new HttpCookie("cart_id");
            cookie.Value = cart_id;
            cookie.Expires = DateTime.Now.AddDays(90);
            Response.Cookies.Add(cookie);
            return cart_id;

        }
        protected string GetIPAddress()
        {
            System.Web.HttpContext context = System.Web.HttpContext.Current;
            string ipAddress = context.Request.ServerVariables["HTTP_X_FORWARDED_FOR"];

            if (!string.IsNullOrEmpty(ipAddress))
            {
                string[] addresses = ipAddress.Split(',');
                if (addresses.Length != 0)
                {
                    return addresses[0];
                }
            }

            return context.Request.ServerVariables["REMOTE_ADDR"];
        }

    }
}
