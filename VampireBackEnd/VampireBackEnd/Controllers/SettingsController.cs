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
            if (settingsChange.settingValue < 0)
            {
                var ret = new messages()
                {
                    content = "Invalid change value, please enter value over 0"
                };
                return Ok(ret);
            }
            var settingToModify = _vampireContext.settings.Where(x => x.settingType.ToLower() == settingsChange.settingType.ToLower()).FirstOrDefault();
            if (settingToModify == null)
            {
                var ret = new messages()
                {
                    content = "Setting was not found"
                };
                return Ok(ret);
            }
            else
            {
                settingToModify.settingValue = settingsChange.settingValue;
                _vampireContext.SaveChanges();
                var ret = new messages()
                {
                    content = "new \"" + settingsChange.settingType + "\" value updated to the value \"" + settingsChange.settingValue + "\""
                };

                return Ok(ret);
            }
        }

        [HttpGet]
        [Route("GetSettingThreshold")]
        public ActionResult GetThreshold()
        {
            var setting = _vampireContext.settings.Where(x => x.settingType.ToLower() == "Threshold".ToLower()).FirstOrDefault();
            if (setting == null)
            {
                var ret = new messages()
                {
                    content = "Setting was not found"
                };
                return Ok(ret);
            }
            else
            {
                return Ok(setting);
            }
        }
    }
}
