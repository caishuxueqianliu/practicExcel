import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)

export default new Vuex.Store({
state: {
  conf:{},
  info:{},
  isConf:false,
  },
mutations: {
	setConf:(state,obj)=>{
state.conf=obj;

  },
  setInfo:(state,obj)=>{
state.info=obj;

  },
setIsConf:(state,obj)=>{
state.isConf=obj;

  }
  },
  actions: {
  },
  modules: {
  }
})
