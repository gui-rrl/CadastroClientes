using CadastroClientes.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace CadastroClientes.Controllers
{
    public class ClienteController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }

        public IActionResult Cadastro(int id)
        {
            Cliente cliente = new Cliente();

            if (id != default (int)){
                cliente = Cliente.SelecionarId(id);
            }
            
            return View(cliente);
        }


        public ActionResult SelecionarTodos()
        {
            List<Cliente> lista = new List<Cliente>();
            lista = Cliente.Selecionar();
            var result = new
            {
                data = lista
            };
            return new JsonResult(result); 
        }

        public int InserirAtualizarCliente(Cliente cliente)
        {
                  
            if(cliente.Id == default(int))
            {
                int res = Cliente.InserirCliente(cliente);
                return res;
            }

            else
            {
                Cliente.AtualizarCliente(cliente);
                return cliente.Id;
            }

            return 0;
        }

        public ActionResult SelecionarPorID(int id)
        {
            Cliente cliente = new Cliente();
            cliente = Cliente.SelecionarId(id);
            return Json(cliente);
        }

        public void ExcluirCliente(int id)
        {
            Cliente.ExcluirCliente(id);
        }
    }
}
