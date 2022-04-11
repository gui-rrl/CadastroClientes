using CadastroClientes.Models;
using Microsoft.AspNetCore.Mvc;
using System.Collections.Generic;

namespace CadastroClientes.Controllers
{
    public class EnderecoController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
        
        public ActionResult SelecionarTodos()
        {
            List<Endereco> lista = new List<Endereco>();
            lista = Endereco.Selecionar();
            var result = new
            {
                data = lista
        };
            return new JsonResult(lista);
        }
        
        public void InserirAtualizarEndereco(Endereco endereco)
        {
                    
            if (endereco.Id == default(int))
            {
                Endereco.InserirEndereco(endereco);
            }

            else
            {
                Endereco.AtualizarEndereco(endereco);
            }
        }

        public ActionResult SelecionarPorID(int id)
        {
            List<Endereco> lista = new List<Endereco>();
            lista = Endereco.Selecionar();
            var result = new
            {
                data = lista
            };
            return new JsonResult(result);
        }

        public void ExcluirEndereco(int id)
        {
            Endereco.ExcluirEndereco(id);
        }
    }
}
