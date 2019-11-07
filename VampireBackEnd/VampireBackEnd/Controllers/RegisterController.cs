using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using VampireBackEnd.Dtos;
using VampireBackEnd.Services;

namespace VampireBackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class RegisterController : ControllerBase
    {
        private VampireContext _vampireContext;
        public RegisterController(VampireContext vampireContext)
        {
            this._vampireContext = vampireContext;
        }
        // example of GET api/Vampire
        [HttpPost]
        // can change routes 
        [Route("User")]
        public ActionResult RegisterUser([FromBody] UserDto user)
        {
            Guid id = Guid.NewGuid();
            var newUser = new User()
            {
                UserId = id,
                firstName = user.firstName,
                lastname = user.lastName,
                userName = user.userName,
                password = user.password
            };
            _vampireContext.users.Add(newUser);
            _vampireContext.SaveChangesAsync();
            return Ok();
        }

    }
}
