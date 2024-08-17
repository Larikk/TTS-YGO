return [====[
{
  "GUID": "421f82",
  "Name": "Custom_Token",
  "Transform": {
    "posX": -108.0,
    "posY": 0.27000007,
    "posZ": 92.0,
    "rotX": -3.480076E-08,
    "rotY": 269.985443,
    "rotZ": 2.650649E-08,
    "scaleX": 2.42111278,
    "scaleY": 1.0,
    "scaleZ": 2.42111278
  },
  "Nickname": "",
  "Description": "",
  "GMNotes": "",
  "ColorDiffuse": {
    "r": 1.0,
    "g": 1.0,
    "b": 1.0
  },
  "LayoutGroupSortIndex": 0,
  "Locked": false,
  "Grid": true,
  "Snap": true,
  "IgnoreFoW": false,
  "MeasureMovement": false,
  "DragSelectable": true,
  "Autoraise": true,
  "Sticky": true,
  "Tooltip": true,
  "GridProjection": false,
  "HideWhenFaceDown": false,
  "Hands": false,
  "CustomImage": {
    "ImageURL": "http://cloud-3.steamusercontent.com/ugc/1778353420788097147/DBAA4B580C19B5774E1B2FE02FAF9DA26AD71C90/",
    "ImageSecondaryURL": "",
    "ImageScalar": 1.0,
    "WidthScale": 0.0,
    "CustomToken": {
      "Thickness": 0.3,
      "MergeDistancePixels": 15.0,
      "StandUp": false,
      "Stackable": false
    }
  },
  "LuaScript": "--[[\n        TTS YuGiOh Lifepoint Script (c) Teofilo Paolucci (Steam: TheRealTeo)\nIf you have any major issues with the script or would like to suggest something,\nComment at the Steam Workshop page here: http://steamcommunity.com/sharedfiles/filedetails/?id=662585353\n--]]\n\n\nLPbutton_params = {\r\n    click_function='nofunction' , function_owner=self , label='8000' ,\r\n    position={0,0.2,-1.6} , rotation={0,0,0} , width=1300 , height=400 , font_size=300\r\n}\r\n\r\nmode_button_params = {\r\n    click_function='switchMode', function_owner=self , label='-' ,\r\n    position={-1.04,0.2,-0.85} , rotation={0,0,0} , width=300 , height = 300, font_size=400\r\n}\r\n\r\nhalf_button_params = {\r\n    click_function='halfLP' , function_owner=self , label='1/2 LP' ,\r\n    position={-0.2,0.2,-0.85} , rotation={0,0,0} , width=500 , height = 300, font_size=100\r\n}\r\n\r\nreset_button_params = {\r\n    click_function='resetLP' , function_owner=self , label='Reset LP' ,\r\n    position={0.83,0.2,-0.85} , rotation={0,0,0} , width=500 , height = 300, font_size=100\r\n}\r\n\r\ntwothou_params = {\r\n    click_function='editTwoThou' , function_owner=self , label='2000' ,\r\n    position={-0.68,0.2,0} , rotation={0,0,0} , width=650 , height = 300, font_size=150\r\n}\r\n\r\nonethou_params = {\r\n    click_function='editOneThou' , function_owner=self , label='1000' ,\r\n    position={0.7,0.2,0} , rotation={0,0,0} , width=650 , height = 300, font_size=150\r\n}\r\n\r\neighthund_params = {\r\n    click_function='editEightHund' , function_owner=self , label='800' ,\r\n    position={-0.92,0.2,0.65} , rotation={0,0,0} , width=430 , height = 300, font_size=150\r\n}\r\n\r\nfivehund_params = {\r\n    click_function='editFiveHund' , function_owner=self , label='500' ,\r\n    position={0,0.2,0.65} , rotation={0,0,0} , width=430 , height = 300, font_size=150\r\n}\r\n\r\nthreehund_params = {\r\n    click_function='editThreeHund' , function_owner=self , label='300' ,\r\n    position={0.92,0.2,0.65} , rotation={0,0,0} , width=430 , height = 300, font_size=150\r\n}\r\n\r\ntwohund_params = {\r\n    click_function='editTwoHund' , function_owner=self , label='200' ,\r\n    position={-0.92,0.2,1.3} , rotation={0,0,0} , width=430 , height = 300, font_size=150\r\n}\r\n\r\nonehund_params = {\r\n    click_function='editOneHund' , function_owner=self , label='100' ,\r\n    position={0,0.2,1.3} , rotation={0,0,0} , width=430 , height = 300, font_size=150\r\n}\r\n\r\nfifty_params = {\r\n    click_function='editFifty' , function_owner=self , label='50' ,\r\n    position={0.92,0.2,1.3} , rotation={0,0,0} , width=430 , height = 300, font_size=150\r\n}\r\n\r\nfunction onLoad()\r\n    life_points = 8000\r\n    mode = false\r\n        --false is subtraction\r\n        --true is addition\r\n    self.createButton(LPbutton_params)              --button index 0\r\n    self.createButton(mode_button_params)           --button index 1\r\n    self.createButton(half_button_params)           --button index 2\r\n    self.createButton(reset_button_params)          --button index 3\r\n    self.createButton(twothou_params)               --button index 4\r\n    self.createButton(onethou_params)               --button index 5\r\n    self.createButton(eighthund_params)             --button index 6\r\n    self.createButton(fivehund_params)              --button index 7\r\n    self.createButton(threehund_params)             --button index 8\r\n    self.createButton(twohund_params)               --button index 9\r\n    self.createButton(onehund_params)               --button index 10\r\n    self.createButton(fifty_params)                 --button index 11\r\nend\r\n\r\nfunction resetLP()\r\n    life_points = 8000\r\n    self.editButton({\r\n        index=0 , label='8000'\r\n    })\r\nend\r\n\r\nfunction switchMode()\r\n    if mode then\r\n        mode = false\r\n        self.editButton({\r\n            index=1 , label='-'\r\n        })\r\n    else\r\n        mode = true\r\n        self.editButton({\r\n            index=1 , label='+'\r\n        })\r\n    end\r\nend\r\n\r\nfunction halfLP()\r\n    life_points = math.floor(life_points / 2)\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editTwoThou()\r\n    if mode then\r\n        life_points = life_points + 2000\r\n    else\r\n        life_points = life_points - 2000\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editOneThou()\r\n    if mode then\r\n        life_points = life_points + 1000\r\n    else\r\n        life_points = life_points - 1000\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editEightHund()\r\n    if mode then\r\n        life_points = life_points + 800\r\n    else\r\n        life_points = life_points - 800\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editFiveHund()\r\n    if mode then\r\n        life_points = life_points + 500\r\n    else\r\n        life_points = life_points - 500\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editThreeHund()\r\n    if mode then\r\n        life_points = life_points + 300\r\n    else\r\n        life_points = life_points - 300\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editTwoHund()\r\n    if mode then\r\n        life_points = life_points + 200\r\n    else\r\n        life_points = life_points - 200\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editOneHund()\r\n    if mode then\r\n        life_points = life_points + 100\r\n    else\r\n        life_points = life_points - 100\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend\r\n\r\nfunction editFifty()\r\n    if mode then\r\n        life_points = life_points + 50\r\n    else\r\n        life_points = life_points - 50\r\n    end\r\n    self.editButton({\r\n        index=0 , label=tostring(life_points)\r\n    })\r\nend",
  "LuaScriptState": "",
  "XmlUI": ""
}
]====]
