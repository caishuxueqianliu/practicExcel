/**
 * Created by lisonevf on 2020/8/20.
 */

var clsDef = {
    0 : "NONE",
    1 : "XGSDK",
    2 : "FACEBOOK",
    3 : "GOOGLEPLAY",
    4 : "TWITTER",
    5 : "XIPU",
    6 : "YUEWAN",
    53 : "YOUDIAN",
    100 : "IOS",
    101 : "XGWORK",
    102 : "ALIPLAY",
    103 : "WXPLAY",
    104 : "MOL",
    105 : "ONESTORE",
    201 : "TAPDB",
    202 : "KOCHAVA",
    203 : "TOUTIAO",
    205 : "APPSFLYER",
    206 : "GDT",
    207 : "MOB",
    300 : "BUD",
}

var externcallbackobj = {
    externcallbackfun : function (json) {
        var cls = eval(this.callbackobj);
        var func = cls[this.callbackfun];
        func(json);
    }
}

var externFunc = {
    callTime : 0,
    isCallFast : function (time){
        var ct = Date.now();

        if(ct - this.callTime > time){
            this.callTime = ct;
            return false;
        }else{
            return true;
        }
    },

    parseParam : function (paramJson) {
        var param = this.parseParam(paramJson);

        if(param.callbackobj){
            this.callbackobj = callbackobj;
        }

        if(param.callbackfun){
            this.callbackfun = callbackfun;
        }

        param.callbackobj = "externcallbackobj";
        param.callbackfun = "externcallbackfun";

        return param;
    },

    xiLogout : function () {
        if(this.isCallFast(500))return;

        var channel = this.loginchannel;

        if(this.inited[channel]){
            var logincls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.logout);
        }
    },
    xiExit : function () {
        if(this.isCallFast(500))return;

        var channel = this.loginchannel;

        if(this.inited[channel]){
            var logincls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.exit);
        }

    },
    //with param
    xiInit : function (paramJson) {
        var param = this.parseParam(paramJson);

        param = this.xiInitSimple(param);

        if(param.loginchannel && param.loginchannel != this.loginchannel){
            var loginchannel = param.loginchannel;
            var logincls = externJson[clsDef[loginchannel]];
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.initParams,paramJson);
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.init,paramJson);
            this.loginchannel = loginchannel;
            this.inited[loginchannel] = true;
        }

        if(param.workchannel && param.workchannel != this.workchannel){
            var workchannel = param.workchannel;
            var workcls = externJson[clsDef[workchannel]];
            jsb.reflection.callStaticMethodbak(workcls.cls,workcls.initParams,paramJson);
            jsb.reflection.callStaticMethodbak(workcls.cls,workcls.init,paramJson);
            this.workchannel = workchannel;
            this.inited[workchannel] = true;
        }

        if(param.statchannel && param.statchannels.indexOf(this.workchannel) != -1){
            var statchannel = param.statchannel;
            var statcls = externJson[clsDef[statchannel]];
            jsb.reflection.callStaticMethodbak(statcls.cls,statcls.initParams,paramJson);
            this.statchannels.push(statchannel);
            this.inited[statchannel] = true;
        }

    },
    xiInitSimple : function (paramJson) {
        var param = this.parseParam(paramJson);

        if(param.callbackobj){
            this.callbackobj = callbackobj;
        }

        if(param.callbackfun){
            this.callbackfun = callbackfun;
        }

        param.callbackobj = "externcallbackobj";
        param.callbackfun = "externcallbackfun";

        return param;
    },
    xiInitLogin : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        if(!this.inited[channel]){
            var logincls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.initParams,paramJson);
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.init,paramJson);
            this.loginchannel = channel;
            this.inited[channel] = true;
        }else {
            this.loginchannel = channel;
        }

    },
    xiInitWork : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        if(!this.inited[channel]){
            var workcls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(workcls.cls,workcls.initParams,paramJson);
            jsb.reflection.callStaticMethodbak(workcls.cls,workcls.init,paramJson);
            this.workchannel = channel;
            this.inited[channel] = true;
        }else {
            this.workchannel = channel;
        }
    },
    xiInitStat : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        if(!this.inited[channel]){
            var statcls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(statcls.cls,statcls.init,paramJson);
            this.statchannels.push(channel);
            this.inited[channel] = true;
        }else {
            if(this.statchannels.indexOf(channel) == -1)
                this.statchannels.push(channel);
        }

    },
    xiLogin : function (paramJson) {
        if(this.isCallFast(500))return;

        var channel = this.loginchannel;

        if(this.inited[channel]){
            var logincls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(logincls.cls,logincls.login,paramJson);
        }
    },
    xiUpUserInfo : function (paramJson) {
        var channel = this.loginchannel;

        var cls = externJson[clsDef[channel]];
        jsb.reflection.callStaticMethodbak(cls.cls,cls.upUserInfo,paramJson);
    },
    xiWork : function (paramJson) {
        if(this.isCallFast(500))return;

        var param = this.parseParam(paramJson);
        var channel = param.channel || this.workchannel;

        if(this.inited[channel]){
            var workcls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(workcls.cls,workcls.workParams,paramJson);
            jsb.reflection.callStaticMethodbak(workcls.cls,workcls.work,paramJson);
        }

    },
    xiLifeCycle : function (paramJson) {
        //useless in ios
    },
    xiUpload : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        var statcls = externJson[clsDef[channel]];
        if(channel){
            jsb.reflection.callStaticMethodbak(statcls.cls,statcls.upload,paramJson);
        }else {
            for (var statchannel in this.statchannels){
                statcls = externJson[clsDef[statchannel]];
                jsb.reflection.callStaticMethodbak(statcls.cls,statcls.upload,paramJson);
            }
        }

    },
    xiShare : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        if(clsDef[channel] == "FACEBOOK"){
            var statcls = externJson[clsDef[channel]];
            jsb.reflection.callStaticMethodbak(statcls.cls,statcls.share,paramJson);
        }

    },
    //with return
    xiChannelInited : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        return this.inited[channel];
    },
    xiVariable : function (paramJson) {

    },
    xiCallFunc : function (paramJson) {
        var param = this.parseParam(paramJson);
        var channel = param.channel;

        var cls = externJson[clsDef[channel]];
        return jsb.reflection.callStaticMethodbak(cls.cls,cls[param.funcName],paramJson);

    },
    xiCallFuncG : function (paramJson) {
        var param = this.parseParam(paramJson);

        var cls = externJson.maincls;

        if(param.getGameName){
            return jsb.reflection.callStaticMethodbak(cls.cls,cls.getGameName);
        }else if(param.createImageButtonOnPosition){
            jsb.reflection.callStaticMethodbak(cls.cls,cls.createImageButtonOnPosition,paramJson);
        }else if(param.removeUIControlByID){
            jsb.reflection.callStaticMethodbak(cls.cls,cls.removeUIControlByID,param.bID);
        }else if(param.clearUI){
            jsb.reflection.callStaticMethodbak(cls.cls,cls.clearUI);
        }

    },
};

(function () {

    cc.loader.loadJson("extern.json", function (err, json) {
        if (err)
            return cc.log("error to load extern.json");

        externJson = json;
    });
})();

jsb.reflection.callStaticMethodbak = jsb.reflection.callStaticMethod;

jsb.reflection.callStaticMethod = function (cls,func,param) {
    var dealFunc = externFunc[func];
    return dealFunc(param);
};