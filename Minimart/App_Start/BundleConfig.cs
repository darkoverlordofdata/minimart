using System.Web;
using System.Web.Optimization;

namespace Minimart
{
    public class BundleConfig
    {
        // For more information on Bundling, visit http://go.microsoft.com/fwlink/?LinkId=254725
        public static void RegisterBundles(BundleCollection bundles)
        {
            BundleTable.EnableOptimizations = false; // true;

            bundles.Add(new ScriptBundle("~/js/jquery").Include(
                        "~/Scripts/js/jquery-2.1.1.js"));

            bundles.Add(new ScriptBundle("~/js/bootstrap").Include(
                        "~/Scripts/js/bootstrap-3.1.1.js"));

            bundles.Add(new ScriptBundle("~/js/liquid").Include(
                        "~/Scripts/js/liquid.coffee-0.0.7.js"));

            bundles.Add(new ScriptBundle("~/js/catalog/index").Include(
                        "~/Scripts/js/catalog/index.js"));

            bundles.Add(new ScriptBundle("~/js/shopping/index").Include(
                        "~/Scripts/js/shopping/index.js"));

            bundles.Add(new ScriptBundle("~/js/shopping/checkout").Include(
                        "~/Scripts/js/jquery.validate.js",
                        "~/Scripts/js/shopping/checkout.js"));

            bundles.Add(new StyleBundle("~/css/site").Include(
                        "~/Content/css/fonts.css",
                        "~/Content/css/bootstrap.css",
                        "~/Content/css/site.css"));



        }
    }
}