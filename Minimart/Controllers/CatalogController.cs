﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data;
using System.Data.SqlClient;
using System.Data.Objects;
using System.Configuration;
using Minimart.Models;
using PagedList;

namespace Minimart.Controllers
{
    public class CatalogController : Controller
    {
        private MinimartEntities storeDB = new MinimartEntities();

        public CatalogController()
        {

            ViewBag.Title = "Mini-Mart";
            ViewBag.MenuHome = "";
            ViewBag.MenuCatalog = "active";
            ViewBag.MenuCart = "";
            ViewBag.MenuCheckout = "";

        }

        [HttpGet]
        public ActionResult Index(string id, int? page)
        {

            return View(storeDB.MM_GetProducts(1).ToList().ToPagedList(1, 6));

            int brand_id = Convert.ToInt32(id);

            if (brand_id > 0)
            {
                MM_GetBrand_Result brand = storeDB.MM_GetBrand(brand_id).ElementAt(0);
                ViewBag.BrandName = brand.name;

            }
            else
            {
                ViewBag.BrandName = "All Brands";
            }

            int pageSize = 6;
            int pageNumber = (page ?? 1);
            return View(storeDB.MM_GetProducts(brand_id).ToList().ToPagedList(pageNumber, pageSize));
        }
    }
}
