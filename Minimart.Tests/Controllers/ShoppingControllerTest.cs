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
    public class ShoppingControllerTest
    {
        [TestMethod]
        public void Index()
        {
            // Arrange
            ShoppingController controller = new ShoppingController();

            //Assert.IsNotNull(controller);
            // Act
            ViewResult result = controller.Index() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Checkout()
        {
            // Arrange
            ShoppingController controller = new ShoppingController();

            // Act
            ViewResult result = controller.Checkout() as ViewResult;

            // Assert
            Assert.IsNotNull(result);
        }

        [TestMethod]
        public void Confirmation()
        {
            // Arrange
            ShoppingController controller = new ShoppingController();

            // Act
            controller.Confirmation("", "", "", "", "", "", "", "", "", "");

            Assert.IsTrue(true);

        }

    }
}
