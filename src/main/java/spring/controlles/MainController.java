package spring.controlles;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import spring.models.User;

@Controller
public class MainController {

    @RequestMapping(value = "/", method = RequestMethod.GET)
    public String indexPage(){
        return "index";
    }

    @RequestMapping(value = "/chat", method = RequestMethod.POST)
    public ModelAndView chatPage(@RequestParam("name")String name, @RequestParam("color")String color){
        ModelAndView mav = new ModelAndView("chat");
        mav.addObject("user", new User(name,color));
        return mav;
    }

}
