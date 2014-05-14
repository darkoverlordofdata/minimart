﻿//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Minimart.Models
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    using System.Data.Objects;
    using System.Data.Objects.DataClasses;
    using System.Linq;
    
    public partial class MinimartEntities : DbContext
    {
        public MinimartEntities()
            : base("name=MinimartEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
    
        public virtual int MM_DelCart(Nullable<int> orderId)
        {
            var orderIdParameter = orderId.HasValue ?
                new ObjectParameter("orderId", orderId) :
                new ObjectParameter("orderId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("MM_DelCart", orderIdParameter);
        }
    
        public virtual ObjectResult<MM_GetBrand_Result> MM_GetBrand(Nullable<int> id)
        {
            var idParameter = id.HasValue ?
                new ObjectParameter("id", id) :
                new ObjectParameter("id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MM_GetBrand_Result>("MM_GetBrand", idParameter);
        }
    
        public virtual ObjectResult<MM_GetCart_Result> MM_GetCart(Nullable<int> orderId)
        {
            var orderIdParameter = orderId.HasValue ?
                new ObjectParameter("orderId", orderId) :
                new ObjectParameter("orderId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MM_GetCart_Result>("MM_GetCart", orderIdParameter);
        }
    
        public virtual ObjectResult<MM_GetOrder_Result> MM_GetOrder(Nullable<int> id)
        {
            var idParameter = id.HasValue ?
                new ObjectParameter("id", id) :
                new ObjectParameter("id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MM_GetOrder_Result>("MM_GetOrder", idParameter);
        }
    
        public virtual ObjectResult<MM_GetProducts_Result> MM_GetProducts(Nullable<int> brandId)
        {
            var brandIdParameter = brandId.HasValue ?
                new ObjectParameter("brandId", brandId) :
                new ObjectParameter("brandId", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<MM_GetProducts_Result>("MM_GetProducts", brandIdParameter);
        }
    
        public virtual ObjectResult<Nullable<decimal>> MM_NewCart(string orderIp)
        {
            var orderIpParameter = orderIp != null ?
                new ObjectParameter("orderIp", orderIp) :
                new ObjectParameter("orderIp", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction<Nullable<decimal>>("MM_NewCart", orderIpParameter);
        }
    
        public virtual int MM_ShipTo(Nullable<int> order_id, string confirmation, string customer_name, string customer_email, string phone_number, string ship_to_name, string ship_to_address1, string ship_to_address2, string ship_to_city, string ship_to_country, string ship_to_state, string ship_to_zip)
        {
            var order_idParameter = order_id.HasValue ?
                new ObjectParameter("order_id", order_id) :
                new ObjectParameter("order_id", typeof(int));
    
            var confirmationParameter = confirmation != null ?
                new ObjectParameter("confirmation", confirmation) :
                new ObjectParameter("confirmation", typeof(string));
    
            var customer_nameParameter = customer_name != null ?
                new ObjectParameter("customer_name", customer_name) :
                new ObjectParameter("customer_name", typeof(string));
    
            var customer_emailParameter = customer_email != null ?
                new ObjectParameter("customer_email", customer_email) :
                new ObjectParameter("customer_email", typeof(string));
    
            var phone_numberParameter = phone_number != null ?
                new ObjectParameter("phone_number", phone_number) :
                new ObjectParameter("phone_number", typeof(string));
    
            var ship_to_nameParameter = ship_to_name != null ?
                new ObjectParameter("ship_to_name", ship_to_name) :
                new ObjectParameter("ship_to_name", typeof(string));
    
            var ship_to_address1Parameter = ship_to_address1 != null ?
                new ObjectParameter("ship_to_address1", ship_to_address1) :
                new ObjectParameter("ship_to_address1", typeof(string));
    
            var ship_to_address2Parameter = ship_to_address2 != null ?
                new ObjectParameter("ship_to_address2", ship_to_address2) :
                new ObjectParameter("ship_to_address2", typeof(string));
    
            var ship_to_cityParameter = ship_to_city != null ?
                new ObjectParameter("ship_to_city", ship_to_city) :
                new ObjectParameter("ship_to_city", typeof(string));
    
            var ship_to_countryParameter = ship_to_country != null ?
                new ObjectParameter("ship_to_country", ship_to_country) :
                new ObjectParameter("ship_to_country", typeof(string));
    
            var ship_to_stateParameter = ship_to_state != null ?
                new ObjectParameter("ship_to_state", ship_to_state) :
                new ObjectParameter("ship_to_state", typeof(string));
    
            var ship_to_zipParameter = ship_to_zip != null ?
                new ObjectParameter("ship_to_zip", ship_to_zip) :
                new ObjectParameter("ship_to_zip", typeof(string));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("MM_ShipTo", order_idParameter, confirmationParameter, customer_nameParameter, customer_emailParameter, phone_numberParameter, ship_to_nameParameter, ship_to_address1Parameter, ship_to_address2Parameter, ship_to_cityParameter, ship_to_countryParameter, ship_to_stateParameter, ship_to_zipParameter);
        }
    
        public virtual int MM_Submit(Nullable<int> order_id)
        {
            var order_idParameter = order_id.HasValue ?
                new ObjectParameter("order_id", order_id) :
                new ObjectParameter("order_id", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("MM_Submit", order_idParameter);
        }
    
        public virtual int MM_UpdateCart(Nullable<int> orderId, Nullable<int> productId, Nullable<decimal> price, Nullable<int> quantity)
        {
            var orderIdParameter = orderId.HasValue ?
                new ObjectParameter("orderId", orderId) :
                new ObjectParameter("orderId", typeof(int));
    
            var productIdParameter = productId.HasValue ?
                new ObjectParameter("productId", productId) :
                new ObjectParameter("productId", typeof(int));
    
            var priceParameter = price.HasValue ?
                new ObjectParameter("price", price) :
                new ObjectParameter("price", typeof(decimal));
    
            var quantityParameter = quantity.HasValue ?
                new ObjectParameter("quantity", quantity) :
                new ObjectParameter("quantity", typeof(int));
    
            return ((IObjectContextAdapter)this).ObjectContext.ExecuteFunction("MM_UpdateCart", orderIdParameter, productIdParameter, priceParameter, quantityParameter);
        }
    }
}