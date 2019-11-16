using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using VampireBackEnd.Models;

// For more information on enabling Web API for empty projects, visit https://go.microsoft.com/fwlink/?LinkID=397860

namespace VampireBackEnd.Controllers
{
    [Route("api/[controller]")]
    public class SettingsController : Controller
    {
        private VampireContext _vampireContext;
        public SettingsController(VampireContext vampireContext)
        {
            this._vampireContext = vampireContext;
        }

        [HttpPut]
        [Route("UpdateSetting")]
        public ActionResult UpdateThreshold([FromBody] SettingDto settingsChange)
        {
            if(settingsChange.settingValue < 0)
            {
                return Ok("Invalid change value, please enter value over 0");
            }
            var settingToModify = _vampireContext.settings.Where(x => x.settingType.ToLower() == settingsChange.settingType.ToLower()).FirstOrDefault();
            if(settingToModify == null)
            {
                return Ok("Setting was not found");
            }
            else
            {
                settingToModify.settingValue = settingsChange.settingValue;
                _vampireContext.SaveChanges();
                return Ok("new \""+ settingsChange.settingType+"\" value updated to the value \"" + settingsChange.settingValue+"\"");
            }
        }

        [HttpGet]
        [Route("GetSettingThreshold")]
        public ActionResult  GetThreshold()
        {
            var setting = _vampireContext.settings.Where(x => x.settingType.ToLower() == "Threshold".ToLower()).FirstOrDefault();
            if(setting == null)
            {
                return Ok("Setting was not found");
            }
            else
            {
                return Ok(setting.settingValue);
            }
        }
    }
}
