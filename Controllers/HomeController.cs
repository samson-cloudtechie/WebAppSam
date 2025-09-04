
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;
using System.Net.Http;
using WebApp.Models;

namespace WebApp.Controllers
{
    public class HomeController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Articles()
        {
            var model = new ArticlesViewModel();
            model.Articles = new ArticleRepository().GetLatest();

            return View(model);
        }
    }
}
