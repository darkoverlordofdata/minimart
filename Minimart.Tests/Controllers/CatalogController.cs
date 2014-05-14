using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.Mvc;
using Microsoft.VisualStudio.TestTools.UnitTesting;
using Minimart;
using Minimart.Controllers;

namespace Minimart.Tests.Controllers
{
    [TestClass]
    public class CatalogControllerTest
    {
        [TestMethod]
        public void Index()
        {
            // Arrange
            CatalogController controller = new CatalogController();

            // Act
            ViewResult result = controller.Index("0", 1) as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

    }
}
