﻿using System.Web;
using System.Web.Mvc;

namespace StudentManagement.v0._04
{
    public class FilterConfig
    {
        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }
    }
}